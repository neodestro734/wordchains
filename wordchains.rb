require 'set'

class WordChainer
	
	#dictionary is a set
	attr_accessor :dictionary, :current_words, :all_seen_words 

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

	#WORKING
	def run(source, target)
		@current_words = [source]
		@all_seen_words = [source]

		until @current_words.empty?
			explore_current_words
		end

	end

	#DONE
	def explore_current_words
		new_current_words = []

		@current_words.each do |cur_word|
			adjacent_words(cur_word).each do |adj_word|
				next if @all_seen_words.include?(adj_word)
				new_current_words << adj_word
				@all_seen_words << adj_word
			end
		end

		@current_words = new_current_words
	end

end

# wc = WordChainer.new('dictionary.txt')
# wc.run('duck','ruby')