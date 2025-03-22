import Foundation

enum CalculatorError: Error {
    case invalidInput
    case divisionByZero
    case integerOverflow
}

class InputParser {
    static let validOperators = ["+", "-", "x", "/", "%"]
    
    static func validateInput(_ args: [String]) -> Bool {
        // Empty input is invalid
        if args.isEmpty {
            return false
        }
        
        // Single number is valid
        if args.count == 1 {
            return isValidNumber(args[0])
        }
        
        // For operations, we need at least 3 arguments (number operator number)
        if args.count < 3 {
            return false
        }
        
        // Check if the pattern is valid: number operator number (operator number)*
        for i in 0..<args.count {
            if i % 2 == 0 {
                // Even positions should be numbers
                if !isValidNumber(args[i]) {
                    return false
                }
            } else {
                // Odd positions should be operators
                if !validOperators.contains(args[i]) {
                    return false
                }
            }
        }
        
        return true
    }
    
    static func isValidNumber(_ str: String) -> Bool {
        // Handle negative numbers
        if str.hasPrefix("-") {
            let number = String(str.dropFirst())
            return Int(number) != nil
        }
        return Int(str) != nil
    }
    
    static func parseNumber(_ str: String) -> Int? {
        return Int(str)
    }
} 
