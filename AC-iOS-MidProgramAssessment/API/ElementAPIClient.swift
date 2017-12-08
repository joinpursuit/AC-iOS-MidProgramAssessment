//
//  ElementAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


struct ElementAPIClient {
    private init() {}
    static let manager = ElementAPIClient()
    func getElement(from urlStr: String, completionHandler: @escaping ([ElementInfo]) -> Void, errorHandler: @escaping (AppError) ->Void) {
        guard let url = URL(string: urlStr) else { return }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let elements = try JSONDecoder().decode([ElementInfo].self, from: data)
                completionHandler(elements)
            } catch {
                errorHandler(.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
