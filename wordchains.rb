require 'set'

class WordChainer
	
	attr_accessor :dictionary #dictionary is a set

	#DONE
	def initialize(dictionary_file)
		dict = File.readlines(dictionary_file).map(&:chomp)
		@dictionary = Set.new(dict)
	end

	#DONE
	def adjacent_words(word)
		@dictionary.select do |d_word|
			keep_word = false
			
			if (d_word.length == word.length)
				diff_chars = 0
				
				d_word.each_char.with_index do |w_char, i|
					if d_word[i] != word[i]
						diff_chars += 1
						break if diff_chars > 1
					end
				end
				keep_word = true if diff_chars == 1

			end
			
		end
	end

end

# wc = WordChainer.new('dictionary.txt')
# p wc.adjacent_words('cat')