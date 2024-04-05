class Game
    @@move_pool = ["A1", "A1", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]

    def game_loop
        game = "ongoing"
        until game == "over"
        end
    end
end

class Player
    @@moves = []
    def initialize(name)
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

class GameOver
    def display(message)
        puts message
    end
end