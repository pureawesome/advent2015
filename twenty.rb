def get_factors(number)
  factors = []
  number.times.with_index do |index|
    index += 1
    break if factors.include? index
    next if number % index != 0
    factors << index
    factors << (number / index)
  end
  factors
end

def get_total(number)
  get_factors(number).inject(:+) * 10
end

@max = 33100000
@max.times do |index|
  next if index == 0
  next if index % 10 != 0
  total = get_total(index)
  if total >= @max
    p index
    break
  end
end
