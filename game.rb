class Game
    @@move_pool = ["A1", "A1", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]
    def initialize
        @move_pool = @@move_pool
        player1 = Player.new("Player 1", @move_pool)
        player2 = Player.new("Player 2", @move_pool)
        board = GameBoard.new(@move_pool)
        game_loop
    end

    def game_loop
        game = "ongoing"
        player = 1
        move
        # loops until the game is over
        until game == "over"
            player == 1 ? mark = "X" : mark = "O"
            # indicates whether it is Player 1 or 2's player to move and gets input
            puts player == 1 ? "Player 1 move:" : "Player 2 move:"
            move = gets
            # ensures that the player input is valid before proceding
            until @move_pool.include?(move.upcase)
                puts "Invalid Input. Try Again..."
                move = gets
            end
            # removes the move from the available move pool
            @move_pool.delete(move)
            # calls the method to display the game board
            board.show_move(move, mark)
            # calls respective player methods to see if, after the move, they have won
            # and then satisfies the game loop and indicates the winner
            if player == 1
                if player1.make_move(move)
                    puts "Player 1 has won!"
                    game = "over"
                end
                player = 2
            else
                if player2.make_move(move)
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

class Player
    @@moves = []
    def initialize(name, array)
        @name = name
        @moves = @@moves
    end
    # adds the move to this player's array to track all of their moves
    # and checks if they have won, returning true or false respectively
    def make_move(move)
        @moves.push(move)
        return check_win ? true : false
    end
    # checks if the player's array includes any of the win combinations
    def check_win
        if @moves.
    end
end

class GameBoard
    def initialize(array)
        @move_array = array
    end
    # replaces the move location in the array with the X or O from the player
    # and calls the display method
    def show_move(move, mark)
        @move_array.map! { |x| x == move ? mark : x }
        display_game
    end
    # displays the array in a readable way to produce a game board in the
    # console
    def display_game
        puts @move_array[0] + " " + @move_array[1] + " " + @move_array[2]
        puts @move_array[3] + " " + @move_array[4] + " " + @move_array[5]
        puts @move_array[6] + " " + @move_array[7] + " " + @move_array[8]
    end
end