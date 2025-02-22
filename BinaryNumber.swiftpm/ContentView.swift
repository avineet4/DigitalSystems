import SwiftUI
import Foundation

struct ContentView: View {
    var body: some View {
        TabView {
            DecimalBinaryConverterView()
                .tabItem {
                    Image(systemName: "number.circle")
                    Text("Converter")
                }
            
            LogicGatesView()
                .tabItem {
                    Image(systemName: "waveform.path")
                    Text("Logic Gates")
                }
            
            BooleanAlgebraView()
                .tabItem {
                    Image(systemName: "sum")
                    Text("Boolean Algebra")
                }
        }
    }
}

// Decimal ↔ Binary Converter Implementation
struct DecimalBinaryConverterView: View {
    @State private var decimalInput: String = ""
    @State private var binaryOutput: String = ""
    @State private var binaryInput: String = ""
    @State private var decimalOutput: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Decimal ↔ Binary Converter")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                
                VStack(spacing: 15) {
                    Text("Convert Decimal to Binary")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    TextField("Enter Decimal Number", text: $decimalInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .onChange(of: decimalInput) { newValue in
                            binaryOutput = convertDecimalToBinary(decimalInput)
                        }
                    
                    Text("Binary Output: \(binaryOutput)")
                        .font(.subheadline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                
                VStack(spacing: 15) {
                    Text("Convert Binary to Decimal")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    TextField("Enter Binary Number", text: $binaryInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .onChange(of: binaryInput) { newValue in
                            decimalOutput = convertBinaryToDecimal(binaryInput)
                        }
                    
                    Text("Decimal Output: \(decimalOutput)")
                        .font(.subheadline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }
    
    func convertDecimalToBinary(_ decimal: String) -> String {
        guard let number = Int(decimal) else { return "Invalid input" }
        return String(number, radix: 2)
    }
    
    func convertBinaryToDecimal(_ binary: String) -> String {
        guard let number = Int(binary, radix: 2) else { return "Invalid input" }
        return String(number)
    }
}

// Logic Gates Implementation
struct LogicGatesView: View {
    @State private var inputA: Bool = false
    @State private var inputB: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Logic Gates Playground")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("Inputs A and B represent two Boolean values (ON/OFF). Toggle them to see how different logic gates process them!")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                VStack(spacing: 15) {
                    Toggle("Input A (ON = 1, OFF = 0)", isOn: $inputA)
                        .padding()
                    Toggle("Input B (ON = 1, OFF = 0)", isOn: $inputB)
                        .padding()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
                
                VStack(spacing: 15) {
                    Text("Logic Gate Outputs")
                        .font(.headline)
                        .padding(.top)
                    
                    LogicGateRow(gate: "AND", result: inputA && inputB)
                    LogicGateRow(gate: "OR", result: inputA || inputB)
                    LogicGateRow(gate: "XOR", result: inputA != inputB)
                    LogicGateRow(gate: "NAND", result: !(inputA && inputB))
                    LogicGateRow(gate: "NOR", result: !(inputA || inputB))
                    LogicGateRow(gate: "XNOR", result: inputA == inputB)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct LogicGateRow: View {
    let gate: String
    let result: Bool
    
    var body: some View {
        HStack {
            Text("\(gate):")
                .font(.headline)
                .frame(width: 80, alignment: .leading)
            Spacer()
            Text(result ? "1" : "0")
                .font(.headline)
                .foregroundColor(result ? .green : .red)
                .frame(width: 50)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

import SwiftUI
import Foundation

struct BooleanAlgebraView: View {
    @State private var expression: String = ""
    @State private var simplifiedExpression: String = ""
    @State private var isAlreadySimplified: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Boolean Algebra Solver")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("Enter a Boolean expression to simplify it. The solver applies Boolean algebra rules to provide a minimized expression.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                TextField("Enter Boolean Expression", text: $expression)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                
                Button(action: {
                    let (simplified, alreadySimplified) = simplifyBooleanExpression(expression)
                    simplifiedExpression = simplified
                    isAlreadySimplified = alreadySimplified
                }) {
                    Text("Simplify")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                }
                .padding(.horizontal)
                
                if !simplifiedExpression.isEmpty {
                    Text("Final Simplified Expression:")
                        .font(.headline)
                        .padding(.top)
                    
                    Text(simplifiedExpression)
                        .font(.title2)
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                
                if isAlreadySimplified {
                    Text("The entered expression is already in its simplest form.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }
    
    func simplifyBooleanExpression(_ expr: String) -> (String, Bool) {
        var expression = expr.replacingOccurrences(of: " ", with: "")
        expression = expression.replacingOccurrences(of: "⋅", with: "*")
        
        class Node {
            var value: String
            var left: Node?
            var right: Node?
            
            init(value: String, left: Node? = nil, right: Node? = nil) {
                self.value = value
                self.left = left
                self.right = right
            }
        }
        
        func parseExpression(_ exp: String) -> Node? {
            if exp.count == 1 {
                return Node(value: exp)
            }
            
            let tokens = Array(exp)
            var operatorIndex = -1
            
            for (index, token) in tokens.enumerated() {
                if token == "+" || token == "*" {
                    operatorIndex = index
                    break
                }
            }
            
            if operatorIndex == -1 { return Node(value: exp) }
            
            let leftPart = String(tokens[0..<operatorIndex])
            let rightPart = String(tokens[(operatorIndex + 1)...])
            let op = String(tokens[operatorIndex])
            
            return Node(value: op, left: parseExpression(leftPart), right: parseExpression(rightPart))
        }
        
        func applyRules(_ node: Node?) -> Node? {
            guard let node = node else { return nil }
            
            let left = applyRules(node.left)
            let right = applyRules(node.right)
            
            if node.value == "+" {
                if left?.value == right?.value { return left }
                if left?.value == "1" || right?.value == "1" { return Node(value: "1") }
            }
            if node.value == "*" {
                if left?.value == "0" || right?.value == "0" { return Node(value: "0") }
                if left?.value == right?.value { return left }
            }
            return Node(value: node.value, left: left, right: right)
        }
        
        func treeToString(_ node: Node?) -> String {
            guard let node = node else { return "" }
            if node.left == nil && node.right == nil { return node.value }
            return "(" + treeToString(node.left) + node.value + treeToString(node.right) + ")"
        }
        
        let root = parseExpression(expression)
        let simplifiedRoot = applyRules(root)
        let simplifiedString = treeToString(simplifiedRoot)
        
        return (simplifiedString, simplifiedString == expr)
    }
}

        // Preview
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
