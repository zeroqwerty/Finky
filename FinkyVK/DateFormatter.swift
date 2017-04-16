//
//  DateFormatter.swift
//  Finky
//
//  Created by DoPPleR on 26.03.17.
//  Copyright © 2017 DoPPleR. All rights reserved.
//

import UIKit

class DateFormatterClass {
    
    static func dateFormatter(dateString: String, fullWeekday: Bool) -> String? {
        
        /// Current date
        let currentDate = NSDate()
        let currentDateFormatDay = DateFormatter()
        currentDateFormatDay.dateFormat = "d"
        let currentDateDay = currentDateFormatDay.string(from: currentDate as Date)
        
        let currentDateFormatMonth = DateFormatter()
        currentDateFormatMonth.dateFormat = "M"
        let currentDateMonth = currentDateFormatMonth.string(from: currentDate as Date)
        
        let currentDateFormatYear = DateFormatter()
        currentDateFormatYear.dateFormat = "Y"
        let currentDateYear = currentDateFormatYear.string(from: currentDate as Date)
        
        /// Date
        let date = NSDate(timeIntervalSince1970: TimeInterval(dateString)!)
        
        // DAY
        let dateFormatDay = DateFormatter()
        dateFormatDay.dateFormat = "d"
        let dateDay = dateFormatDay.string(from: date as Date)
        let intDate = Int(dateDay)
        
        // MONTH
        let dateFormatMonth = DateFormatter()
        dateFormatMonth.dateFormat = "M"
        let dateMonth = dateFormatMonth.string(from: date as Date)
        //let intMonth = Int(dateMonth)
        
        // YEAR
        let dateFormatYear = DateFormatter()
        dateFormatYear.dateFormat = "Y"
        let dateYear = dateFormatYear.string(from: date as Date)
        //let intYear = Int(dateYear)
        
        let DateFormat = DateFormatter()
        
        if currentDateYear == dateYear {
            if currentDateMonth == dateMonth {
                if currentDateDay == dateDay {
                    
                    DateFormat.dateFormat = "H:mm"
                    let dateString = DateFormat.string(from: date as Date)
                    
                    if fullWeekday {
                        return "Сегодня, \(dateString)"
                    } else {
                        return dateString
                    }
                    
                } else if currentDateDay == String((intDate! + 1)) {
                    
                    DateFormat.dateFormat = "H:mm"
                    let dateString = DateFormat.string(from: date as Date)
                    
                    if fullWeekday {
                        return "Вчера, \(dateString)"
                    } else {
                        return "Вчера"
                    }
                    
                } else {
                    DateFormat.dateFormat = "d MMM"
                    return DateFormat.string(from: date as Date)
                }
            } else { // month
                DateFormat.dateFormat = "d MMM"
                return DateFormat.string(from: date as Date)
            }
        } else { // year
            DateFormat.dateFormat = "d MMM YYYY"
            return DateFormat.string(from: date as Date)
        }
    }
    
}
