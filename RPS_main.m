% Rock, paper, and scissors
% out: 1) rock, 2) paper, 3) scissors
% rock wins scissors, paper wins rock, scissors win paper
% if winning with trump, score is doubled
%% Choose player models and initialize how many rounds
clear, clc
% set initials
amount_of_rounds = 1000; % how many rounds playing
% select game mode: #1 opponent's trump is known, #2 opponent's trump is unknown
game_mode=1; % game_mode=2; % TODO: game_mode 2 is not implemented yet
addpath('./models')  
disp(['%%%%%%%%%%%%%%%%%%%%%',10,'Rock, paper, and scissors'])
% set models for both players
player1_model = 'random guess'; 
player1_model = 'weighted trump'; 
player2_model = 'opposite to opponent"s most frequent';

%% Draw trumps
player1_trump = randi([1,3],1);
player2_trump = randi([1,3],1);
disp(['Player 1 model is ',player1_model,' and trump is ',convert_inputnumber_to_rps(player1_trump)]);
disp(['Player 2 model is ',player2_model,' and trump is ',convert_inputnumber_to_rps(player2_trump)]);
%% Play
results = zeros(amount_of_rounds,3); % [points_p1, points_p2, ties];%
log_of_played_values = []; % log what are each player has taken 
for round_index = 1:amount_of_rounds
    fprintf('Roound %d/%d',round_index,amount_of_rounds);
    % function out = get_model_output(model_name, trump, log, player_number)
    % player_number is required for some models to know which on is opponent
    if game_mode == 1
        % in game mode #1, opponent's trump is known
        player1_pick = get_model_output(player1_model, ...
            player1_trump, player2_trump,log_of_played_values,1);
        player2_pick = get_model_output(player2_model, ...
            player2_trump, player1_trump,log_of_played_values,2);
    elseif game_mode == 2
        % in game mode #2, opponent's trump is unknown
        player1_pick = get_model_output(player1_model, ...
            player1_trump, [],log_of_played_values,1);
        player2_pick = get_model_output(player2_model, ...
            player2_trump, [],log_of_played_values,2);
    end

	fprintf(': Picks %s & %s',convert_index_to_rsp_string(player1_pick),...
        convert_index_to_rsp_string(player2_pick));
    log_of_played_values(end+1,:) = [player1_pick, player2_pick];
    result_current = compare_picks(player1_pick, player2_pick, ...
        player1_trump, player2_trump); % current round
    results(round_index,:) = result_current; % set current result
    fprintf('\n')
end
%% display results
plot_results

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compare picks
function result = compare_picks(player1_pick, player2_pick, ...
    player1_trump, player2_trump)
    if player1_pick == player2_pick
        result = [0 0 1]; % tie
    elseif player1_pick == 1 && player2_pick == 3
        % if rock & scissors
        result = [1 0 0]; % first player wins
    elseif player1_pick == 2 && player2_pick == 1
        % if paper & rock
        result = [1 0 0]; % first player wins
    elseif player1_pick == 3 && player2_pick == 2
        % if scissors & paper
        result = [1 0 0]; % first player wins
    else % in any other case, % 2nd player wins
        result = [0 1 0]; 
    end
    result = check_if_result_is_doubled(result, player1_pick, player1_trump, ...
        player2_pick, player2_trump);
end

% check if winner won with trump, if yes, double the points
function result = check_if_result_is_doubled(result,...
        player1_pick,player1_trump,player2_pick,player2_trump)
    if result(end) ~= 1 % if not tie, double points if winner wins with trump
        % check if winner won with trump
        if result(1) == 1 && isequal(player1_pick,player1_trump) ...
                || result(2) == 1 && isequal(player2_pick,player2_trump)
            % when won with trump, double points  
            result = 2*result;
%             disp('Winning with trump! Double score')
            fprintf('--> Winning with trump! Double score')

        end
    end
end

% convert output number to 
function name = convert_inputnumber_to_rps(number)
    if number == 1
        name = 'rock';
    elseif number == 2
        name = 'paper';
    elseif number == 3
        name = 'scissors';
    else
       error('No valid input, choose integrer 1, 2, or 3')  
    end
end

% get output from model
function out = get_model_output(model_name, player_trump, opponent_trump, log, player_number)
% function out = get_model_output(model_name, player_trump, opponent_trump, log, player_number)
    narginchk(1,5)
    if nargin < 3 || isempty(opponent_trump)
        % if opponent's trump is not known (game mode#2)
        opponent_trump = 'nan';
    end
    switch model_name
        case 'random guess'
            out = random_guess(3); % 3 for rock, paper, and scissors
        case 'weighted trump'
            out = weighted_trump(player_trump);
        case 'opposite to opponent"s most frequent'
            out = opposite_to_opponents_freq(player_trump, log, player_number);
        otherwise
            error('No given model found!')
    end
end

% convert input index to rsp string: rock, paper, or scissors
function out = convert_index_to_rsp_string(input)
% input indexes: 1) rock, 2) paper, 3) scissors
if input == 1  
    out = 'rock';
elseif input == 2 
    out = 'paper'; 
elseif input == 3 
    out = 'scissors';
else
    error('Not proper input given!')
end

end
