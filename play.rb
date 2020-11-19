class Hangman
    def initialize
        #instance variable
        @letters = ('a'...'z').to_a #to array
        @word = words.sample #picks random from array
        @lives = 7
        @word_teaser = ""
        @word.first.length.times do 
            @word_teaser += "_ "
        end
        @winner = false
    end

    def words
        [
            ["cricket", "A game played by gentlemen..."],
            ["jogging", "We are not walking..."],
            ["celebrate", "Capturing special moments..."],
            ["continent", "There are 7 of these..."],
            ["exotic", "Not from around here..."],
            ["costco", "An amazing super store..."],
            ["brother", "Part of a family..."],
            ["hammer", "Friends with a nail..."]
        ]
    end

    def print_teaser(last_guess = nil) 
        update_teaser(last_guess) unless last_guess.nil?
        puts "\n"
        puts @word_teaser
    end

    def update_teaser(last_guess)
        new_teaser = @word_teaser.split
        new_teaser.each_with_index do |letter, index |
            if letter == "_" && @word.first[index] == last_guess
                new_teaser[index] = last_guess
            end

            @word_teaser = new_teaser.join(" ")
        end
    end

    def final 
        final = @word_teaser.split
        new_final = final.join("")
        if new_final == @word.first 
            @winner = true
        end
    end

    def make_guess
        final
        if !@winner
            if @lives > 0
                puts "\n"
                puts "Enter a letter"
                puts "\n"
                guess = gets.chomp
                puts "\n"
                if guess == "exit"
                    puts "\n"
                    puts "Thank you for playing!"
                elsif guess == "clue"
                    puts "\n"
                    puts @word.last
                    make_guess
                elsif guess.length > 1
                    puts "\n"
                    puts "Invalid Answer. Try again."
                    make_guess
                else 
                    if @letters.include? guess
                        puts "\n"
                        puts "You guessed #{guess}"

                        correct = @word.first.include? guess
                        
                        
                        if correct
                            puts "\n"
                            puts "You picked correctly."

                            @letters.delete(guess)
                            print_teaser(guess)
                            
                            make_guess
                        else
                            @letters.delete(guess)
                            @lives -= 1
                            puts "\n"
                            puts "You picked incorrectly. You have #{@lives} lives left. Try again."
                            puts "\n"
                            puts @word_teaser
                            puts "\n"
                            make_guess
                        end
                    else
                        puts "\n"
                        puts @word_teaser
                        puts "\n"
                        puts "You have already guessed #{guess}. Try again."
                        make_guess
                    end 
                end
            else
                puts "\n"
                puts "GAME OVER! You are out of lives and have lost"
            end
        else
            puts "\n"
            puts "Congratulations you are correct and guessed the word #{guess}! WELL DONE!"
        end
    end

    def begin
        puts "-----------------------------------------"
        #ask user for a letter
        puts "New game has started... your word has #{@word.first.length} letters." 
        puts "\n"
        puts "To exit game, type exit. For a clue, type clue."
        puts "\n"
        print_teaser
        
        puts "\n\n"
        puts "Your clue is #{@word.last}"
        puts "\n"
        
        
        puts "\n"
        make_guess
    end
end

game = Hangman.new()

game.begin()