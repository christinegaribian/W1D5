require 'byebug'

class PolyTreeNode

  def initialize(value = nil)
    @parent, @children, @value = nil, [], value
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
   @value
  end

  def parent=(value)
    unless self.parent.nil?
      #remove self from its current parent's children array
      current_index = self.parent.children.index(self)
      self.parent.children.delete_at(current_index)
    end

    # reassign parent value of this node
    @parent = value

    # add this node to new parent's children unless it's already there
    return nil if self.parent.nil?
    sibling_arr = self.parent.children
    sibling_arr << self unless sibling_arr.include?(self)
  end

  def add_child(child_node)
    self.children << child_node
    child_node.parent = self
  end


  def remove_child(child_node)
    child_node.parent = nil
    current_index = self.children.index(child_node)
    self.children.delete_at(current_index)
  end

  def dfs(target)
    return self if self.value == target
    self.children.each do  |child|
      result = child.dfs(target)
      return result unless result.nil?
    end

    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      current = queue.shift
      return current if current.value == target
      current.children.each {|child| queue << child }
    end
    nil
  end

end
