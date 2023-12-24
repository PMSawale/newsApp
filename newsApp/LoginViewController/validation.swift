//
//  validation.swift
//  newsApp
//
//  Created by Pankaj Sawale on 04/09/23.
//

import Foundation


func isPasswordValid(_ password : String) -> Bool {
    
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    return passwordTest.evaluate(with: password)
}

func isValidEmail(_ email: String) -> Bool {
    // Regular expression pattern for a basic email validation
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

    if let range = email.range(of: emailRegex, options: .regularExpression) {
        return email.distance(from: range.lowerBound, to: range.upperBound) == email.count
    }

    return false
}
