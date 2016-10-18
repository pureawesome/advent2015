@molecule = 'CRnCaCaCaSiRnBPTiMgArSiRnSiRnMgArSiRnCaFArTiTiBSiThFYCaFArCaCaSiThCaPBSiThSiThCaCaPTiRnPBSiThRnFArArCaCaSiThCaSiThSiRnMgArCaPTiBPRnFArSiThCaSiRnFArBCaSiRnCaPRnFArPMgYCaFArCaPTiTiTiBPBSiThCaPTiBPBSiRnFArBPBSiRnCaFArBPRnSiRnFArRnSiRnBFArCaFArCaCaCaSiThSiThCaCaPBPTiTiRnFArCaPTiBSiAlArPBCaCaCaCaCaSiRnMgArCaSiThFArThCaSiThCaSiRnCaFYCaSiRnFYFArFArCaSiRnFYFArCaSiRnBPMgArSiThPRnFArCaSiRnFArTiRnSiRnFYFArCaSiRnBFArCaSiRnTiMgArSiThCaSiThCaFArPRnFArSiRnFArTiTiTiTiBCaCaSiRnCaCaFYFArSiThCaPTiBPTiBCaSiThSiRnMgArCaF'
# @molecule = 'HOH'
patterns = []
total_indexes = 0

combos = File.readlines('nineteen.txt').map(&:strip).each do |combo|
  combo = combo.split(' => ')
  next unless @molecule =~ /#{combo[0]}/
  indexes = []

  @molecule.scan /#{combo[0]}/ do |i|
    indexes << $~.offset(0)[0]
  end
  total_indexes += indexes.size

  indexes.map do |index|
    molecule_copy = @molecule.dup
    molecule_copy[index...(index + combo[0].size)] = combo[1]
    patterns << molecule_copy
  end
end

# p patterns.uniq.size

@molecule = 'HOHOHO'
part2 = 'e'
combo2 = File.readlines('nineteen_test.txt').map(&:strip).map do |combo|
  combo.split(' => ')
end

patterns2 = [part2]
steps = 0

until patterns2.include? @molecule
  patterns2 = patterns2.map do |pattern|
    new_outputs = []
    combo2.each do |combo|
      next unless pattern =~ /#{combo[0]}/

      indexes = []
      pattern.scan /#{combo[0]}/ do |i|
        indexes << $~.offset(0)[0]
      end

      indexes = indexes.map do |index|
        dup = pattern.dup
        dup[index...(index + combo[0].size)] = combo[1]
        dup
      end
      new_outputs << indexes
    end
    new_outputs
  end.flatten.uniq

  steps += 1
end
p steps

  # next unless @molecule =~ /#{combo[0]}/
  # indexes = []
  #
  # @molecule.scan /#{combo[0]}/ do |i|
  #   indexes << $~.offset(0)[0]
  # end
  # total_indexes += indexes.size
  #
  # indexes.map do |index|
  #   molecule_copy = @molecule
  #   molecule_copy[index...(index + combo[0].size)] = combo[1]
  #   patterns << molecule_copy
  # end
# end
