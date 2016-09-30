# Evaluate Postfix expression
# pseudo code

#  Let take P as postfix expression
#  Step 1: Loop Steps 2 to 3 until P is empty
#     Step 2: if operand found, Push to Stack
#     Step 3: If operator found,
#                    pop last two(topmost) elements from the stack
#                    and apply operation and push result back to Stack
# Step 4: pop last element from stack as result
# Step 5: Exit

# require '/home/qbuser/Ruby/Postfix/stack.rb'


class EvaluatePostfix
  def initialize(postfix_string)
    @postfix_string =  postfix_string
  end

  def evaluate
    stack = Stack.new

    splitup.each do |element|
      p stack
      p '-----'
      case element
      when /^(0|[1-9][0-9]*)$/ #numeric?(element)
        stack.push(element.to_i)
      when "+", "-", "*", "/"
        stack.push(find_result(stack, element))
      when "^"
        rhs = stack.pop
        lhs = stack.pop
        stack.push(lhs ** rhs)
      else
        raise "Unexpected element! - #{element}"
      end
    end

    p  "Result is #{stack.pop}"
  end

  def splitup
    @postfix_string.split(' ')
  end

  def numeric? element
    element.match(/^(0|[1-9][0-9]*)$/)
  end

  def find_result(stack, operator)
    rhs = stack.pop
    lhs = stack.pop
    lhs.send(operator, rhs.to_f)
  end
end
