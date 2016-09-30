# To generate Postfix from Infix expression

# pseudo code
# Let us take I as Infix expression - input to the class

# Step 1: Initialize Postfix variable "P" and "OS" as operator stack
# Step 2: Loop step 6 - until operator stack is empty
#     Step 3: If operand is found, Add it to the variable "P"
#     Step 4: If "(" is found, add it to Stack
#     Step 5: If operator found then,
#              add to the Operator Stack and pop operator has same or high precedence and add to "P"
#     Step 6: IF ")" is found then
#              then pop all operators until "(" is found and add to "P" and remove "(" from Stack.
# Step 7: If Operator stack is not empty, pop operator and add to P.


class GeneratePostfix

  OP_PRECEDENCE = {
    "^": 4,
    "*": 3,
    "/": 3,
    "+": 2,
    "-": 2,
    "(": 0
  }

  OP_ASSOCIATIVE = {
    "^": "Right",
    "*": "Left",
    "/": "Left",
    "+": "Left",
    "-": "Left"
  }

  def initialize(infix_expression)
    @infix_expression = infix_expression
    @output = ""
  end

  def execute
    operator_stack = Stack.new
    p splitup

    splitup.each do |token|
      case token
      when /^(0|[1-9][0-9]*)$/ #numeric
        @output += "#{token} "
      when "("
        operator_stack.push(token)
      when "+", "-", "*", "/", "^"
        operator_operation(operator_stack, token)
      when ")"
        right_parenthesis_operation(operator_stack)
       else
       	raise "Unexpected token! - #{token}"
      end
    end
    process_remaining_stack(operator_stack)

    @output
  end

  # If operator found, see STEP 5
  def operator_operation(operator_stack, current_operator)
    until operator_stack.empty?
      operator = operator_stack.pop
      if check_operator_predence_and_associative(current_operator, operator)
        @output += "#{operator} "
      else
        operator_stack.push(operator)
        break
      end
    end
    operator_stack.push(current_operator)
  end

  # If ")" is found, see STEP 6
  def right_parenthesis_operation(operator_stack)
    until operator_stack.empty?
      operator = operator_stack.pop
      p operator
      if operator == "("
        break
      else
        @output += "#{operator} "
      end
    end
  end

  # IF stack is not empty, see STEP 7
  def process_remaining_stack(operator_stack)
    until operator_stack.empty?
      operator = operator_stack.pop
      @output += "#{operator} "
    end
  end

  def splitup
    @infix_expression.split(' ')
  end

  # POP from stack and and to output IF
  #   current op is left-associative and its precedence is less than or equal top op at Stack
  #  										OR
  #   current op is right associative, and has precedence less than that of top op at Stack
  def check_operator_predence_and_associative(current_operator, operator)
    ((OP_PRECEDENCE[current_operator.to_sym] <= OP_PRECEDENCE[operator.to_sym]) and left_associative?(operator)) ||
    ((OP_PRECEDENCE[current_operator.to_sym] > OP_PRECEDENCE[operator.to_sym]) and right_associative?(operator))
  end

  def left_associative?(operator)
    OP_ASSOCIATIVE[operator.to_sym].eql?("Left")
  end

  def right_associative?(operator)
    OP_ASSOCIATIVE[operator.to_sym].eql?("Right")
  end

end
