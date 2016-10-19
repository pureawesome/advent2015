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

@molecule = 'CRnCaCaCaSiRnBPTiMgArSiRnSiRnMgArSiRnCaFArTiTiBSiThFYCaFArCaCaSiThCaPBSiThSiThCaCaPTiRnPBSiThRnFArArCaCaSiThCaSiThSiRnMgArCaPTiBPRnFArSiThCaSiRnFArBCaSiRnCaPRnFArPMgYCaFArCaPTiTiTiBPBSiThCaPTiBPBSiRnFArBPBSiRnCaFArBPRnSiRnFArRnSiRnBFArCaFArCaCaCaSiThSiThCaCaPBPTiTiRnFArCaPTiBSiAlArPBCaCaCaCaCaSiRnMgArCaSiThFArThCaSiThCaSiRnCaFYCaSiRnFYFArFArCaSiRnFYFArCaSiRnBPMgArSiThPRnFArCaSiRnFArTiRnSiRnFYFArCaSiRnBFArCaSiRnTiMgArSiThCaSiThCaFArPRnFArSiRnFArTiTiTiTiBCaCaSiRnCaCaFYFArSiThCaPTiBPTiBCaSiThSiRnMgArCaF'
# @molecule = 'HOHOHO'
part2 = 'e'
part2_mol = @molecule.dup
kvs = Hash.new { |h, k| h[k] = [] }
File.readlines('nineteen.txt').map(&:strip).map do |combo|
  combo = combo.split(' => ')
  kvs[combo[1]] = combo[0]
end
kvs = kvs.sort_by { |k, _v| k.size }.reverse
steps = 0

until part2_mol == part2
  break if steps >= 1000

  kvs.each do |k, v|
    next unless part2_mol =~ /#{k}/
    count = 0
    part2_mol.scan(/#{k}/) do
      count += 1
    end

    part2_mol.gsub!(/#{k}/, v)
    steps += count
  end
end
p steps
