require 'set'

class WordChainer
	
	#dictionary is a set
	attr_accessor :dictionary, :current_words, :all_seen_words, :all_current_words

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

	#DONE
	def run(source, target)
		@current_words = [source]
		@all_seen_words = [source]
		@all_current_words = [[nil]]

		until @current_words.empty?
			explore_current_words
		end

		build_path(source, target)

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
		@all_current_words << @current_words
	end

	#DONE
	def build_path(source, target)
		# find the index where the target is found
		i_with_target = find_target_i_in_all_words(target)

		# path = [target]
		path = build_path_helper([target], i_with_target)

		(path << source).reverse
	end

	private
	
	#WORKING -> make this recursive
	def build_path_helper(path, i_with_target)
		i = i_with_target - 1

		until i < 1
			adj_w_src = adjacent_words(path.last)

			@all_current_words[i].each do |all_word|
				if adj_w_src.include?(all_word)
					path << all_word
					break
				end
			end

			i -= 1
		end
		path
	end

	#DONE
	def find_target_i_in_all_words(target)
		i_with_target = nil
		(0...@all_current_words.length).to_a.reverse.each do |cur_words_i|
			if @all_current_words[cur_words_i].include?(target)
				i_with_target = cur_words_i
				break
			end
		end
		i_with_target
	end

end

# wc = WordChainer.new('dictionary.txt')
# wc.run('cat','dog')