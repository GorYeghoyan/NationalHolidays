//
//  HolidayRequest.swift
//  NationalHolidays
//
//  Created by Gor Yeghoyan on 1/18/20.
//  Copyright © 2020 Gor Yeghoyan. All rights reserved.
//

import UIKit
import Foundation

enum HolidayError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct HolidayRequest{
    let resourceURL: URL
    let API_KEY = "4cb2fe8677a199a0feffa732ab78ef4344f4938c"
                
    
    init(countryCode: String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        
        
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
       
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getHolidays(completion: @escaping(Result<[HolidayDetails], HolidayError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data
                else {
                    completion(.failure(.noDataAvailable))
                    return
            }
            
            do {
                let decoder = JSONDecoder()
                let holidaysResponce = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidaysResponce.response.holidays
                completion(.success(holidayDetails))
            }catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
    
    
}
