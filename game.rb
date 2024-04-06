class Game
    @@move_pool = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]
    @@win_combos = [
        ["A1", "A2", "A3"], 
        ["B1", "B2", "B3"],
        ["C1", "C2", "C3"],
        ["A1", "B1", "C1"],
        ["A2", "B2", "C2"],
        ["A3", "B3", "C3"],
        ["A1", "B2", "C3"],
        ["C1", "B2", "A3"]
    ]

    def initialize
        @move_pool = @@move_pool
        @board = GameBoard.new(@@win_combos)
        @player1 = Player.new("Player 1", @board)
        @player2 = Player.new("Player 2", @board)
        @board.display_game
        game_loop
    end

    def game_loop
        game = "ongoing"
        player = 1
        move = "no move"
        mark = " "
        # loops until the game is over
        until game == "over"
            player == 1 ? mark = "X " : mark = "O "

            # indicates whether it is Player 1 or 2's player to move and gets input
            puts player == 1 ? "Player 1 move:" : "Player 2 move:"
            move = gets.chomp.upcase!
            # ensures that the player input is valid before proceding
            while !@move_pool.include?(move)
                puts "Invalid Input. Try Again..."
                move = gets.chomp.upcase!
            end

            # removes the move from the available move pool
            @move_pool.delete(move)
            # calls the method to display the game board
            @board.show_move(move, mark)
            # calls respective player methods to see if, after the move, they have won
            # and then satisfies the game loop and indicates the winner
            if player == 1
                if @player1.make_move(move)
                    puts "Player 1 has won!"
                    game = "over"
                end
                player = 2
            else
                if @player2.make_move(move)
                    puts "Player 2 has won!"
                    game = "over"
                end
                player = 1
            end

            # checks if there are any available plays and ends the game if not
            if @move_pool.length == 0
                puts "It's a tie!"
                game = "over"
            end
        end
    end
end

class Player < Game
    def initialize(name, board)
        @name = name
        @moves = []
        @board = board
    end

    # adds the move to this player's array to track all of their moves
    # and checks if they have won, returning true or false respectively
    def make_move(move)
        @moves.push(move)
        return @board.check_win(@moves) ? true : false
    end
end

class GameBoard
    @@move_array = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]
    def initialize(win_combos)
        @move_array = @@move_array
        @win_combos = win_combos
    end

    # replaces the move location in the array with the X or O from the player
    # and calls the display method
    def show_move(move, mark)
        @move_array.map! { |x| x == move ? x = mark : x }
        display_game
    end

    # displays the array in a readable way to produce a game board in the
    # console
    def display_game
        puts @move_array[0] + " " + @move_array[1] + " " + @move_array[2]
        puts @move_array[3] + " " + @move_array[4] + " " + @move_array[5]
        puts @move_array[6] + " " + @move_array[7] + " " + @move_array[8]
    end

    # returns true if the passed in player's array includes any winning combos
    def check_win(move)
        # loop through each nested array inside the whole array to see if
        # the player's array includes any win combos and return accordingly
        @win_combos.each do |nested_combo|
            has_won = nested_combo.all? { |element| move.include?(element) }
            if has_won
                return true
            end
        end
        return false
    end
end

Game.new