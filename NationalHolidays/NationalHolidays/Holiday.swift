//
//  Holiday.swift
//  NationalHolidays
//
//  Created by Gor Yeghoyan on 1/18/20.
//  Copyright © 2020 Gor Yeghoyan. All rights reserved.
//

import UIKit
import Foundation


struct HolidayResponse: Decodable {
    var response: Holidays
}

struct Holidays: Decodable {
    var holidays: [HolidayDetails]
}

struct HolidayDetails: Decodable {
    var name: String
    var date: DateInfo
}

struct DateInfo: Decodable {
    var iso: String
}

