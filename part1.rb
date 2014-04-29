	
#project 1 part 1: Questions 1-6
 
 
#---------- Question 1: Hello World ----------#
class HelloWorldClass
    def initialize(name)
       @name = name.capitalize
    end
    def sayHi
        puts "Hello #{@name}!"
    end
end
hello = HelloWorldClass.new("Andrew")
hello.sayHi
 
 
#---------- Question 2: Palindromes ----------#
 
def palindrome?(string)
    x = string.downcase.gsub(/\W/,"")
    puts x
    puts x == x.reverse
end
 
palindrome?("A man, a plan, a canal -- Panama")
palindrome?("Madam, I'm Adam!")
palindrome?("Abracadabra")
 
#---------- Question 3: Word Count ----------#
#http://www.ruby-doc.org/core-2.1.0/Hash.html
 
def count_words(string)
    x = string.downcase
    y = x.scan(/\w+/)
 
    wordcount = Hash.new(0)
    y.each{|word| wordcount[word] += 1}
    puts wordcount
    return wordcount
end
 
 
count_words("A man, a plan, a canal -- Panama")
count_words "Doo bee doo bee doo"
 
 
#---------- Question 4: Rock, Paper, Scissors ----------#
 
class WrongNumberOfPlayersError <  StandardError ; end
 
class NoSuchStrategyError <  StandardError ; end
 
  
 
def rps_game_winner(game)
 
    raise WrongNumberOfPlayersError unless game.length == 2
 
 
    game[0][1] = game[0][1].downcase
    game[1][1] = game[1][1].downcase
 
    moves = {"r" => "rock", "s" => "scissors", "p" => "paper"}
    raise NoSuchStrategyError unless (game[0][1] == "r" or game[0][1] == "p" or game[0][1] == "s")
    raise NoSuchStrategyError unless (game[1][1] == "r" or game[1][1] == "p" or game[1][1] == "s")
 
    name1 = game[0][0]
    name2 = game[1][0]
 
    if game[0][1] == game[1][1]
        puts "#{name1} wins!!!!!!!"
    else
        strategy = game[0][1] + game [1][1]
    end
 
    #possible game combinations: pp, rr, ss     player 1 wins  - handled
    #                            sp, rs, pr     player 1 wins
    #                            ps, sr, rp     player 2 wins
    if strategy == "sp"
        puts "#{name1} wins with #{moves[game[0][1]]}!!!!!"
        return game[0]
    end
    if strategy == "rs"
        puts "#{name1} wins with #{moves[game[0][1]]}!!!!!"
        return game[0]
    end
    if strategy == "pr"
        puts "#{name1} wins with #{moves[game[0][1]]}!!!!!"
        return game[0]
    end
    if strategy == "ps"
        puts "#{name2} wins with #{moves[game[1][1]]}!!!!!"
        return game[1]
    end
    if strategy == "sr"
        puts "#{name2} wins with #{moves[game[1][1]]}!!!!!"
        return game[1]
    end
    if strategy == "rp"
        puts "#{name2} wins with #{moves[game[1][1]]}!!!!!"
        return game[1]
    end
end
 
 
 
game1 = [["chuck","r"],["buster","p"]]
rps_game_winner(game1)
 
 
def rps_tournament_winner(tournament)
 
    if tournament[0][0].is_a?(String)
        return rps_game_winner(tournament)
    else
        return rps_tournament_winner([rps_tournament_winner(tournament[0]), rps_tournament_winner(tournament[1])])
    end
end
 
puts rps_tournament_winner([
    [
        [ ["Armando", "P"], ["Dave", "S"] ],
        [ ["Richard", "R"],  ["Michael", "S"] ],
    ],
    [
        [ ["Allen", "S"], ["Omer", "P"] ],
        [ ["David E.", "R"], ["Richard X.", "P"] ]
    ]
])
 
 
 
 
 
#---------- Question 5: Anagrams ----------#
 
#http://www.ruby-doc.org/core-2.1.0/String.html
def combine_anagrams(words)
  counter = 0
  output_array = Array.new
  words.each do |w1|
    temp_array = []
    words.each do |w2|
      if (w2.downcase.split(//).sort == w1.downcase.split(//).sort)
        temp_array.push(w2)
        counter+=1
      end
    end
    output_array.push(temp_array)
    output_array.push(counter)
    counter = 0
  end
  puts output_array.uniq
  return output_array.uniq
end
 
 
 
combine_anagrams(['cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream'])
 
 
 
#---------- Question 6: Global Match ----------#
 
def glob_match(filenames, pattern)
    pat = pattern.gsub(/[A-z]/) {|c| '(' + c + ')'}
    pat.gsub!(/[*]/, '*' => '.*', '?' => '.')
    array=[]
    filenames.each{|filename| filename.match(pat) {|mat| array << mat[0]}}   
    return array
 
 
end
 
puts glob_match(["part1.rb","part2.rb","part2.rb~",".part3.rb.un~"],"*part*rb?*")
