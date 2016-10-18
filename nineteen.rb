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

p patterns.uniq.size
