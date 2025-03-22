import Foundation

class Calculator {
    
    /// For multi-step calculation, it's helpful to persist existing result
    var currentResult = 0
    
    /// Perform Addition
    func add(no1: Int, no2: Int) -> Int {
        return no1 + no2
    }
    
    /// Perform Subtraction
    func subtract(no1: Int, no2: Int) -> Int {
        return no1 - no2
    }
    
    /// Perform Multiplication
    func multiply(no1: Int, no2: Int) -> Int {
        return no1 * no2
    }
    
    /// Perform Division
    func divide(no1: Int, no2: Int) throws -> Int {
        if no2 == 0 {
            throw CalculatorError.divisionByZero
        }
        return no1 / no2
    }
    
    /// Perform Modulus
    func modulus(no1: Int, no2: Int) throws -> Int {
        if no2 == 0 {
            throw CalculatorError.divisionByZero
        }
        return no1 % no2
    }
    
    /// Calculate Result from the arguments with proper precedence
    func calculate(args: [String]) throws -> String {
        // Validate input
        if !InputParser.validateInput(args) {
            throw CalculatorError.invalidInput
        }
        
        // Handle single number case
        if args.count == 1 {
            return String(InputParser.parseNumber(args[0])!)
        }
        
        // Convert string arguments to numbers and operators
        var numbers: [Int] = []
        var operators: [String] = []
        
        for (index, arg) in args.enumerated() {
            if index % 2 == 0 {
                let number = InputParser.parseNumber(arg)
                if number != nil {
                    numbers.append(number!)
                } else {
                    throw CalculatorError.invalidInput
                }
            } else {
                operators.append(arg)
            }
        }
        
        // Multiplication, Division and Modulus handler
        var i = 0
        while i < operators.count {
            if operators[i] == "x" || operators[i] == "/" || operators[i] == "%" {
                let result: Int
                do {
                    if operators[i] == "x" {
                        result = multiply(no1: numbers[i], no2: numbers[i + 1])
                    } else if operators[i] == "/" {
                        result = try divide(no1: numbers[i], no2: numbers[i + 1])
                    } else {
                        result = try modulus(no1: numbers[i], no2: numbers[i + 1])
                    }
                    
                    // Replace the two numbers and operator with the result
                    numbers[i] = result
                    numbers.remove(at: i + 1)
                    operators.remove(at: i)
                } catch {
                    throw error
                }
            } else {
                i += 1
            }
        }
        
        // Addition and Subtraction handler
        var finalResult = numbers[0]
        for i in 0..<operators.count {
            if operators[i] == "+" {
                finalResult = add(no1: finalResult, no2: numbers[i + 1])
            } else if operators[i] == "-" {
                finalResult = subtract(no1: finalResult, no2: numbers[i + 1])
            }
        }
        
        return String(finalResult)
    }
}