class Game
    @@move_pool = ["A1", "A1", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]
    def initialize
        @move_pool = @@move_pool
        player1 = Player.new("Player 1")
        player2 = Player.new("Player 2")
        game_loop
    end

    def game_loop
        game = "ongoing"
        player = 1
        play
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
            GameBoard.display_game(move, mark)
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
    def initialize(name)
        @name = name
        @moves = @@moves
    end

    def make_move(move)
        @moves.push(move)
        CheckWin.check_win(@moves)
    end
end

class GameBoard
    def display_game(move_array)
    end
end

class CheckWin
    def check_win(move_array)
    end
end