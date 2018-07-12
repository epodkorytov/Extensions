//
//  Date+Extension.swift
//  Extensions
//

import Foundation

public extension Date {
    public func toString(with dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    public func compareWithDate(_ target:Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self) == dateFormatter.string(from: target)
    }
    
    
    public enum TimeUnit {
        case seconds
        case minutes
        case hours
        case days
        case weeks
        case months
        case years
    }
    public func valueOfTime(in unit: TimeUnit) -> Int {
        let time = self.timeIntervalSince1970
        let now = Date().timeIntervalSince1970
        
        let sec:Double = abs(now - time)
        if unit == .seconds {
            return Int(sec)
        }
        let min:Double = round(sec/60)
        if unit == .minutes {
            return Int(min)
        }
        let hr:Double = round(min/60)
        if unit == .hours {
            return Int(hr)
        }
        let days:Double = round(min/24)
        if unit == .days {
            return Int(days)
        } else if unit == .weeks {
            return Int(round(days / 7))
        } else if unit == .months {
            return Int(round(days / 30))
        } else {
            return Int(round(days / 365))
        }
    }
    
}
