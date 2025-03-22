import Foundation

class InputParser {
    static let validOperators = ["+", "-", "x", "/", "%"]

    static func validateInput(_ args: [String]) -> Bool {
        // Empty input is invalid
        if args.isEmpty {
            return false
        }

        // Single argument is valid only if it's a number
        if args.count == 1 {
            return parseNumber(args[0]) != nil
        }

        if args.count < 3 {
            return false
        }

        // Check if the pattern is valid
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
