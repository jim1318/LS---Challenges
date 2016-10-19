def check_diag(poss, n)
  transform = poss.each_with_index.map{ |row, col| row + col + 1 }
  return false if transform.uniq.count < n

  transform2 = poss.each_with_index.map{ |row, col| row + (8 - col)}
  return false if transform2.uniq.count < n

  return true
end

def queens(n)
  row = (1..n).to_a 
  p row.permutation(n).select{ |poss| check_diag(poss, n)}.count
end




queens(5)
queens(6)
queens(7)
queens(8)
queens(9)
queens(10)
queens(11)
queens(12)

