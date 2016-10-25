@boss = {}
@weapons = []
@armor = []
@rings = []
@ref_arr = ''
@you = {
  'hp' => 100,
  'd' => 0,
  'a' => 0
}

File.readlines('twentyone_boss.txt').each do |line|
  arr = line.split(':').map(&:strip)
  arr[0].gsub!(/[a-z]\s|[a-z]/, '').downcase!
  @boss[arr[0]] = arr[1].to_i
end

File.readlines('twentyone_store.txt').each do |line|
  @ref_arr = '@weapons' if line =~ /^Weapo/
  @ref_arr = '@armor' if line =~ /^Armor/
  @ref_arr = '@rings' if line =~ /^Rings/

  options = line.split(' ').select { |item| !(item =~ /^\d*$/).nil? }.map(&:to_i)
  next if options.empty?
  hash = {}
  hash['c'] = options[0]
  hash['d'] = options[1]
  hash['a'] = options[2]
  arr = eval(@ref_arr)
  arr << hash
end

empty = {
  'c' => 0,
  'd' => 0,
  'a' => 0
}

@armor << empty
2.times { @rings << empty }

@weapons_costs = @weapons.map { |x| x['c'] }
@armor_costs = @armor.map { |x| x['c'] }.sort
@rings_costs = @rings.map { |x| x['c'] }.sort

def generate_combos
  combos = []
  @ring_combos = @rings_costs.combination(2).to_a
  @weapons_costs.each do |w_cost|
    @armor_costs.each do |a_cost|
      combos << @ring_combos.map { |ring| [w_cost, a_cost] + ring }
    end
  end
  combos.flatten(1).sort { |x, y| x.inject(:+) <=> y.inject(:+) }
end

def combo_to_stats(arr)
  weapon = @weapons.find { |hash| hash['c'] == arr[0] }
  armor = @armor.find { |hash| hash['c'] == arr[1] }
  ring1 = @rings.find { |hash| hash['c'] == arr[2] }
  ring2 = @rings.find { |hash| hash['c'] == arr[3] }

  @you.dup.merge!(weapon) { |_k, v1, v2| v1 + v2 }
      .merge!(armor) { |_k, v1, v2| v1 + v2 }
      .merge!(ring1) { |_k, v1, v2| v1 + v2 }
      .merge!(ring2) { |_k, v1, v2| v1 + v2 }
end

def battle_boss(player)
  boss = @boss.dup
  winner = 'player'

  loop do
    player_attack = player['d'] - boss['a']
    player_attack = (player_attack > 0) ? player_attack : 1
    boss['hp'] = boss['hp'] - player_attack
    winner = 'player'
    break if boss['hp'] < 1

    boss_attack = boss['d'] - player['a']
    boss_attack = (boss_attack > 0) ? boss_attack : 1
    player['hp'] -= boss_attack
    winner = 'boss'
    break if player['hp'] < 1
  end
  winner
end

def run_this_shit
  cost = 0
  sorted_combos = generate_combos
  sorted_combos.each do |combo|
    player = combo_to_stats(combo)
    winner = battle_boss(player)
    cost = combo
    break if winner == 'player'
  end
  cost.inject(:+)
end

def run_this_shit_2
  sorted_combos = generate_combos
  losing_combos = sorted_combos.select do |combo|
    player = combo_to_stats(combo)
    winner = battle_boss(player)
    combo if winner == 'boss'
  end
  losing_combos.last.inject(:+)
end

p run_this_shit_2
