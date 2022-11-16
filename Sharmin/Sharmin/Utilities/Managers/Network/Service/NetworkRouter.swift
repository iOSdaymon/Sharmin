//
//  NetworkService.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/07.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouterProtocol: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class NetworkRouter<EndPoint: EndPointType>: NetworkRouterProtocol {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request,
                                    completionHandler: { data, response, error in
                
                self.printDataResponse(response, request: request, data: data)
                
                if let httpResponse = response as? HTTPURLResponse {
                    if (200..<300).contains(httpResponse.statusCode) {
                        completion(data, response, error)
                    } else {
                        completion(nil, httpResponse, error)
                    }
                } else {
                    completion(nil, nil, error)
                }
            })
        }catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.apiPath),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: Constants.TimeInterval.request)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue(Constants.Text.applicationJson, forHTTPHeaderField: Constants.Text.contentType)
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            
            debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
            debugPrint("REQUEST")
            debugPrint("URL: \(request.url?.absoluteString ?? "")")
            debugPrint("allHTTPHeaderFields: \(request.allHTTPHeaderFields ?? [:])")
            debugPrint("Body: \(request.httpBody ?? Data())")
            debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
            return request
        } catch {
            throw error
        }
    }
    
    private func configureParameters(bodyParameters: Parameters?,
                                     bodyEncoding: ParameterEncoding,
                                     urlParameters: Parameters?,
                                     request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters,
                                    urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}

// MARK: - Response printing

private extension NetworkRouter {
    
    func printDataResponse(_ dataResponse: URLResponse?, request: URLRequest?, data: Data?) {
#if DEBUG
        var printString = "\n\n-------------------------------------------------------------\n"
        
        if let urlDataResponse = dataResponse as? HTTPURLResponse {
            let statusCode = urlDataResponse.statusCode
            printString += "\(statusCode == 200 ? "SUCCESS" : "ERROR") \(statusCode)\n"
        }
        
        var responceArray: [[String: Any]] = []
        // REQUEST
        if let request = request {
            var requestArray: [[String: Any]] = []
            
            // URL
            requestArray.append(["!!!<URL>!!!": request.url?.absoluteString ?? ""])
            
            // HEADERS
            if let headers = request.allHTTPHeaderFields {
                requestArray.append(["!!!<HEADERS>!!!": headers])
            } else {
                requestArray.append(["!!!<HEADERS>!!!": ["SYSTEM PRINT": "No Headers"]])
            }
            
            // PARAMETERS
            if let httpBody = request.httpBody {
                do {
                    let temDictData = try JSONSerialization.jsonObject(with: httpBody, options: .allowFragments)
                    requestArray.append(["!!!<PARAMETERS>!!!": temDictData])
                } catch {
                    requestArray.append(["!!!<PARAMETERS>!!!": ["SYSTEM PRINT": "Throw error: \(error)"]])
                }
            }
            
            responceArray.append(["!!!<REQUEST>!!!": requestArray])
        } else {
            responceArray.append(["!!!<REQUEST>!!!": [["SYSTEM PRINT": "No Request"]]])
        }
        
        // RESPONSE
        do {
            if let data = data {
                let temDictData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                responceArray.append(["!!!<RESPONSE>!!!": temDictData])
            } else {
                responceArray.append(["!!!<RESPONSE>!!!": ["SYSTEM PRINT": "No Data"]])
            }
            
        } catch {
            responceArray.append(["!!!<RESPONSE>!!!": ["SYSTEM PRINT": "Throw error: \(error)"]])
        }
        
        // Print
        do {
            var httpMethod = request?.httpMethod ?? ""
            if !httpMethod.isEmpty {
                httpMethod += "\n"
            }
            
            let data = try JSONSerialization.data(withJSONObject: ["!!!<RESTAPIMANAGER>!!!": responceArray], options: .prettyPrinted)
            var responceString = String.init(data: data, encoding: .utf8) ?? ""
            responceString = responceString.replacingOccurrences(of: "\"!!!<RESTAPIMANAGER>!!!\" :", with: "")
            responceString = responceString.replacingOccurrences(of: "{\n   [\n    {\n      \"!!!<REQUEST>!!!\" : ", with: "\n\(httpMethod)REQUEST:")
            responceString = responceString.replacingOccurrences(of: "[\n        {\n          \"!!!<URL>!!!\" : ", with: "\n\tURL: \n\t\t  ")
            responceString = responceString.replacingOccurrences(of: "        },\n        {\n          \"!!!<HEADERS>!!!\" : ", with: "\tHEADERS: \n\t\t  ")
            responceString = responceString.replacingOccurrences(of: "\n        },\n        {\n          \"!!!<PARAMETERS>!!!\" : ", with: "\n\tPARAMETERS:\n\t\t  ")
            responceString = responceString.replacingOccurrences(of: "\n        }\n      ]\n    },\n    {\n      \"!!!<RESPONSE>!!!\" : ", with: "\nRESPONSE:\n\t  ")
            responceString = responceString.replacingOccurrences(of: "\\/", with: "/")
            if responceString.count > 12 {
                responceString.removeLast(12) // "\n    }\n  ]\n}"
            }
            
            if responceString.isEmpty {
                responceString = "Can't create string from responce"
            }
            
            printString += responceString + "\n"
        } catch {
            printString += "ERROR PRINTING RESPONCE\n"
        }
        
        printString += "-------------------------------------------------------------\n\n"
        
        print(printString)
#endif
    }
}
