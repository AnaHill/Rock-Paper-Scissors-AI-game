# Rock-Paper-Scissors-AI-game
Traditional Rock Paper Scissors game to study different ("AI") models. 

Create model and play against other models!

## How to play
- Choose models for both players (in file _RPS_main.m_)
  - E.g. to set player 2 model to _opposite to opponent"s most frequent_, write following:
    - `player2_model = 'opposite to opponent"s most frequent';`
- Run file _RPS_main.m_
## How to implement new model to game
1. Create a new MATLAB function for your model
   - current possible function inputs are following (only model_name is required, other are optional): 
     - _model_name_, _player_trump_, _opponent_trump_, _log_, player_number;
   - function should return only a single output number of 1, 2, or 3 (numbers are refering to rock, paper, and scissors, respectively)
   - E.g. see `function out = opposite_to_opponents_freq(player_trump, log, _player_number_)`
2. Add model inside switch case in function ` get_model_output(model_name, player_trump, opponent_trump, log, player_number)` in file _RPS_main.m_
   - E.g. Add `opposite to opponent"s most frequent` model with following commands, where model calling name is _opposite to opponent"s most frequent_ and function file name _opposite_to_opponents_freq.m_: 
     - `case 'opposite to opponent"s most frequent'`
     - `out = opposite_to_opponents_freq(trump, log, player_number);`
1. If you want to play with your model, change calling name of player 1 or 2 (or both) model to your model
   - E.g. to set player 2 model to _opposite to opponent"s most frequent_, write following: 
     - `player2_model = 'opposite to opponent"s most frequent';`

## TODO and possible future implementations
- [ ] better instructions
- [ ] GUI implementation with
  - [ ] plotting results on "real-time" and/or as an animation with wanted speed (e.g. 10 games per second)
  - [ ] option to name players
- [ ] Implement more advanced (AI) models 
- [ ] Different gaming options
  - [ ] Choose does one know opponent's trump (default, game mode#1) or only own (game mode#2)
  - [ ] others, e.g. change rule so that score is reduced if player looses when picked trump
