#Part 2: Questions 7-11
 
#---------- Question 7: Object-Oriented Programming ----------#

#http://www.railstips.org/blog/archives/2006/11/18/class-and-instance-variables-in-ruby/
class Dessert
 
    def initialize(name, calories)
        @calories = calories
        @name = name
    end
 
    def healthy?
        if @calories < 200
            return true
        else return false
        end
    end
 
    def delicious?
        return true
    end
end
 
class JellyBean < Dessert
 
    def initialize(name, calories, flavor)
        @flavor = flavor
        @name = name
        @calories = calories
    end
 
    def delicious?
        if @flavor == 'black licorice'
            return false
        else return true
        end
    end
 
end
 
cake = Dessert.new("cake", 500)
puts cake.delicious?
puts cake.healthy?
 
rootbeer = JellyBean.new("root beer", 100, "root beer")
bl = JellyBean.new("black licorice", 100, 'black licorice')
puts bl.delicious?
puts bl.healthy?
 
#---------- Question 8: Attribute Accessor With History ----------#
 
 
#attribute accessor
#http://stackoverflow.com/questions/9561072/ruby-using-class-eval-to-define-methods
#http://www.ruby-doc.org/core-2.1.0/Class.html
#http://stackoverflow.com/questions/4370960/what-is-attr-accessor-in-ruby
 
 
#the purpose of this is to include attr_reader and attr_writer, encapsulated into attr accessor
#We implement this by using open classes
#all objects of class "whatever" (foo in this case) are instances of class Class
#we can edit class Class and add a new definition
 
#http://www.jimmycuadra.com/posts/metaprogramming-ruby-class-eval-and-instance-eval
#class eval is a way to dynamically create instance methods when you don't know what the
#attribute will be named yet
 
class Class
 
    def attr_accessor_with_history(attribute_name)
            attr_name = attribute_name.to_s
            attr_reader attr_name
            attr_reader attr_name+"_history"
            class_eval %Q"
        def #{attr_name}=value
            if !defined?
                    @#{attr_name}_history
                @#{attr_name}_history =[@#{attr_name}]
            end
            @#{attr_name} = value
            @#{attr_name}_history << value
        end
    "
    end
end
 
 
class Foo
    attr_accessor_with_history :bar
end
 
p = Foo.new
p.bar = "Andrew G"
 
puts p.bar
 
p.bar = "Meghan F"
 
puts p.bar
 
p.bar = "Boulder Colorado"
puts p.bar
 
puts "object history: "
puts p.bar_history
 
 
 
 
#---------- Question 9: Currency Conversion ----------#
 
#http://stackoverflow.com/questions/9651612/ruby-method-missing
 
class Numeric
 
    @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1}
 
    def method_missing(method_id)
 
        singular_currency = method_id.to_s.gsub( /s$/, '')
 
        if@@currencies.has_key?(singular_currency)
 
            self*@@currencies[singular_currency]
        else
            super
        end
    end
 
 
 
    def in(currency)
        singular_currency = currency.to_s.gsub( /s$/, '')
        self / @@currencies[singular_currency]
    end
end
 
n = Numeric.new
 
puts 4.dollar.in(:rupee)
 
 
#---------- Question 10: Palindromes Again ----------#
 
 
#class Palindrome
    # def initialize(input)
    #   @word = input
    # end
 
#http://www.ruby-doc.org/core-2.1.0/String.html
 
class String
 
    def palindrome?
        x = self.downcase.gsub(/\W/,"")
        puts x == x.reverse
    end
end
 
p = "Palindrome.new"
p.palindrome?
 
p= "A man, a plan, a canal -- Panama"
p.palindrome?
 
p="Madam, I'm Adam!"
p.palindrome?
 
p="Abracadabra"
p.palindrome?
 
#http://ruby-doc.org/core-2.1.0/Enumerable.html
 
 
module Enumerable
    def palindrome?
        puts self.collect{|i| i} == self.collect{|i|i}.reverse
    end
end
 
x = [1,2,3,2,1]
x.palindrome?
 
x = [5,6,7]
x.palindrome?
 
 
#---------- Question 11: Blocks ----------#
#http://ruby-doc.org/core-2.1.0/Enumerable.html
 
class CartesianProduct #can't inherit modules here
 
    include Enumerable
 
    def initialize(s1,s2)
        @s1=s1
        @s2=s2
    end
 
    def each
        unless @s1.empty? && s2.empty?
        combo_sequence = []
        @s1.each do |seq1|
            combo_sequence << @s2.each {|seq2| yield [seq1] << seq2}
        end
    end
    end
end
 
 
c = CartesianProduct.new([:a,:b], [4,5])
 
c.each { |elt| puts elt.inspect }
 
 
  
 
c = CartesianProduct.new([:a,:b], [])
 
c.each { |elt| puts elt.inspect }

