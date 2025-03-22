import Foundation

class Calculator {

    /// For multi-step calculation, it's helpful to persist existing result
    var currentResult = 0

    /// Perform Addition
    func add(a: Int, b: Int) -> Int {
        return a + b
    }

    /// Perform Subtraction
    func subtract(a: Int, b: Int) -> Int {
        return a - b
    }

    /// Perform Multiplication
    func multiply(a: Int, b: Int) -> Int {
        return a * b
    }

    /// Perform Division
    func divide(a: Int, b: Int) throws -> Int {
        if b == 0 {
            throw CalculatorError.divisionByZero
        }
        return a / b
    }

    /// Perform Modulus
    func modulus(a: Int, b: Int) throws -> Int {
        if b == 0 {
            throw CalculatorError.divisionByZero
        }
        return a % b
    }

    func performOperation(a: Int, b: Int, operator: String) throws -> Int {
        do {
            switch `operator` {
            case "x":
                return multiply(a: a, b: b)
            case "/":
                return try divide(a: a, b: b)
            case "%":
                return try modulus(a: a, b: b)
            case "+":
                return add(a: a, b: b)
            case "-":
                return subtract(a: a, b: b)
            default:
                return 0
            }
        } catch {
            throw error
        }
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
        do {
            var i = 0
            while i < operators.count {
                // print("iteration number \(i) \(numbers) \(operators)")
                if operators[i] == "x" || operators[i] == "/" || operators[i] == "%" {
                    let result = try performOperation(
                        a: numbers[i], b: numbers[i + 1], operator: operators[i])

                    // print(result, numbers[i], numbers[i + 1], operators[i])
                    numbers[i] = result
                    // print("remove number: \(numbers[i + 1])")
                    numbers.remove(at: i + 1)
                    // print("remove operator: \(operators[i])")
                    operators.remove(at: i)
                } else {
                    // go to next operator
                    i += 1
                }
            }

            // Addition and Subtraction handler
            var finalResult = numbers[0]
            for i in 0..<operators.count {
                // print(finalResult, finalResult, numbers[i + 1], operators[i])
                finalResult = try performOperation(
                    a: finalResult, b: numbers[i + 1], operator: operators[i])
            }

            return String(finalResult)
        } catch {
            throw error
        }
    }
}
