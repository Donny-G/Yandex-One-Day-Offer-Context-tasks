# Yandex-One-Day-Offer-Context-tasks
Решения задач на отборочном этапе Yandex One Day Offer

A. Сравнение двух последовательностей

Ограничение времени	10 секунд
Ограничение памяти	256.0 Мб
Ввод	стандартный ввод или input.txt
Вывод	стандартный вывод или output.txt
Вам даны две последовательности нажатий на клавиши клавиатуры в поле ввода, которые включают в себя буквы, цифры и нажатия клавиши backspace.
Вам необходимо проверить совпадают ли строки которые отображаются в поле ввода после выполнения каждой из этих двух последовательностей нажатия клавиш
Напишите код, который позволяет сравнивать такие две последовательности нажатий на клавиши клавиатуры. Постарайтесь написать решение c алгоритмической сложностью O(n+m) и дополнительной памятью в размере O(1)
Формат ввода

Две последовательности символов передаются в виде строки с пробелом в качестве разделителя последовательностей и знака '.' в качестве обозначения клавиши backspace
Формат вывода

Необходимо напечатать true, если результирующие строки в поле ввода будут совпадать или false, если они будут отличаться
Пример 1
abc. abd.
true

Пример 2
aaaa... bbbb...
false


C. Добавить операцию в калькулятор

Ваш коллега написал приложение-калькулятор и ушел в отпуск. Ваша команда хочет выпустить приложение для клиентов, но оказалось, что оно не поддерживает операцию возведения в степень.
Вам нужно добавить поддержку новой операции – возведение в степень (оператор ^).
Ожидается, что вы так же проведете рефакторинг текущего кода, чтобы получить наиболее простое, поддерживаемое и расширяемое решение (в будущем нам могут потребоваться операторы "(", ")" и другие).
Примечания

func evalArithmeticExpression(_ input: String) -> Double {
    let operators = [
        (name: "+", associativityIsLeft: true, precedence: 10),
        (name: "-", associativityIsLeft: true, precedence: 10),
        (name: "*", associativityIsLeft: true, precedence: 20),
        (name: "/", associativityIsLeft: true, precedence: 20),
        ]
    
    var output: [Double] = []
    var opStack: [(name: String, associativityIsLeft: Bool, precedence: Int)] = []

    for token in input.components(separatedBy: .whitespaces) {
        let number = Double(token)
        if (number != nil) {
            output += [number!]
        } else {
            let op = operators[operators.firstIndex(where: { $0.name == token })!]

            while !opStack.isEmpty {
                let topOperator = opStack.last!
                
                if op.associativityIsLeft && op.precedence <= topOperator.precedence || !op.associativityIsLeft && op.precedence < topOperator.precedence {
                    opStack.popLast()
                    let rhs = output.popLast()!, lhs = output.popLast()!
                    var result: Double = 0
                    if topOperator.name == "+" {
                        result = rhs + lhs
                    } else if topOperator.name == "-" {
                        result = lhs - rhs
                    } else if topOperator.name == "*" {
                        result = lhs * rhs
                    } else if topOperator.name == "/" {
                        result = lhs / rhs
                    }
                    output.append(result)
            
                } else {
                    break
                }
            }

            opStack += [op]
        }
    }
    
    while !opStack.isEmpty {
        let topOperator = opStack.popLast()!
        
        let rhs = output.popLast()!, lhs = output.popLast()!
        var result: Double = 0

        if topOperator.name == "+" {
            result = rhs + lhs
        } else if topOperator.name == "-" {
            result = lhs - rhs
        } else if topOperator.name == "*" {
            result = lhs * rhs
        } else if topOperator.name == "/" {
            result = lhs / rhs
        }
        
        output.append(result)
    }
    return output[0]
}

B. Let's Try: SwiftUI

Представьте, что вы разработчик Яндекса.
Вам дали задание сверстать макет виджета на Swift UI.
В виджете отображается текущее время, а по кнопке старт каждую секунду меняется цвет двоеточия.
Дизайнер передал все необходимые параметры:
<img width="358" alt="Снимок экрана 2021-05-27 в 18 38 37" src="https://user-images.githubusercontent.com/49961778/119965678-32f68500-bfb3-11eb-80da-61501a8f9012.png">

