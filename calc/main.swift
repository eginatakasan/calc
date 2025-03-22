import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst()
let calculator = Calculator()

do {
    // Calculate the result
    let result = try calculator.calculate(args: args)
    print(result)
} catch CalculatorError.invalidInput {
    print("invalid input")
    exit(1)
} catch CalculatorError.divisionByZero {
    print("division by zero")
    exit(1)
} catch CalculatorError.integerOverflow {
    print("integer overflow")
    exit(1)
} catch {
    print("unknown error")
    exit(1)
}
