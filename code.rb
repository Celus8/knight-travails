class Position
attr_reader :moves, :pos, :father

  def initialize(pos, father = nil)
    @pos = pos
    @father = father
    @moves = []
  end
  
  def create_moves
    (1..2).each do |i|
      (1..2).each do |j|
        unless (i == j)
          unless @pos[0] + i > 7
            unless @pos[1] + j > 7
              @moves.push(Position.new([@pos[0] + i, @pos[1] + j], self))
            end
            unless @pos[1] - j < 0
              @moves.push(Position.new([@pos[0] + i, @pos[1] - j], self))
            end
          end
          unless @pos[0] - i < 0
            unless @pos[1] + j > 7
              @moves.push(Position.new([@pos[0] - i, @pos[1] + j], self))
            end
            unless @pos[1] - j < 0
              @moves.push(Position.new([@pos[0] - i, @pos[1] - j], self))
            end
          end
        end
      end
    end
  end
end

def knight_moves(pos, final, queue = [], knight_pos = nil)
  if knight_pos.nil?
    knight_pos = Position.new(pos)
    knight_pos.create_moves
    queue.push(knight_pos)
  end
  if knight_pos.pos == final
    path = [knight_pos.pos]
    temp_pos = knight_pos
    loop do |i|
      break if temp_pos.father == nil
      path.unshift(temp_pos.father.pos)
      temp_pos = temp_pos.father
    end
    print "You made it in #{path.length - 1} moves! Here is your path:"
    path.each { |i| print "\n#{i}"}
    return
  end
  queue += knight_pos.moves
  queue.shift
  queue.each_with_index do |posit1, i|
    posit1.create_moves
    queue.each_with_index do |posit2, j|
      if posit1.pos == posit2.pos && i != j
        queue.delete_at(j)
      end
    end
  end
  queue.compact!
  knight_moves(queue[0].pos, final, queue, queue[0])
end

print "#{knight_moves([0, 0], [5, 7])}\n"
