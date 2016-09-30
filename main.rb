require '/home/qbuser/Ruby/Postfix/evaluate_postfix.rb'
require '/home/qbuser/Ruby/Postfix/generate_postfix.rb'
require '/home/qbuser/Ruby/Postfix/stack.rb'

generate_postfix = GeneratePostfix.new('( 5 + 1 / 1 + 5 - 2 ) * ( 3 / 2 + 3 )')
p o = generate_postfix.execute


evaluate_postfix = EvaluatePostfix.new(o)
p evaluate_postfix	.evaluate

