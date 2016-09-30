class Stack

  include Enumerable

  def initialize
    @stack = []
  end

  def each(&block)
    @stack.each(&block)
  end

  def push item
    @stack.push(item)
  end

  def pop
    raise 'UnderFlow Error'  if empty?
    @stack.pop
  end

  def get_last
    @stack.last
  end

  def empty?
    @stack.empty?
  end
end
