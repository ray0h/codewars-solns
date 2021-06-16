class Calculator
    def operate(a, oper, b)
        case oper
        when '+'
            return a + b
        when '-'
            return a - b
        when '*'
            return a * b
        when '/'
            return a / b.to_f
        else
            return 'error'
        end
    end

    def replace(arr, operInd)
        value = operate(arr[operInd-1], arr[operInd], arr[operInd+1])
        arr.slice!(operInd-1, 3)
        arr.insert(operInd-1, value)
        arr
    end

    def higher(arr)
        arr.include?('*') || arr.include?('/')
    end

    def evaluate(string)
        oper = ['+','-','*','/']
        input = string.split(' ').map{|c| oper.include?(c) ? c : c.to_i}
       
        while higher(input)
            inds = [input.index('*'), input.index('/')].filter{|x| !x.nil?}
            ind = inds.min
            input = replace(input, ind)
        end
        input = replace(input, 1) until input.length === 1
        input[0]
    end
end

calc = Calculator.new

calc.evaluate('2 + 3 + 4')
