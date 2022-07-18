% Rock, paper, and scissors
% out: 1) rock, 2) paper, 3) scissors
% rock wins scissors, paper wins rock, scissors win paper
%% Choose player models and initialize how many rounds
clear, clc
disp(['%%%%%%%%%%%%%%%%%%%%%',10,'Rock, paper, and scissors'])
player1_model = 'random guess'; % choose
player2_model = 'weight trump'; % choose
player2_model = 'opposite to opponent"s most frequent';
amount_of_rounds = 1000; % how many rounds plauer
%% Draw trumps
player1_trump = randi([1,3],1);
player2_trump = randi([1,3],1);
disp(['Player 1 model is ',player1_model,' and trump is ',convert_inputnumber_to_rps(player1_trump)]);
disp(['Player 2 model is ',player2_model,' and trump is ',convert_inputnumber_to_rps(player2_trump)]);
%% Play
results = zeros(amount_of_rounds,3); % [points_p1, points_p2, ties];%
picks_log = []; % log what are each player has taken 
for round_index = 1:amount_of_rounds
    fprintf('Roound %d/%d',round_index,amount_of_rounds);
    % function out = get_model_output(model_name, trump, log, player_number)
    % player_number is required for some models to know which on is opponent
    player1_pick = get_model_output(player1_model, player1_trump,picks_log,1);
    player2_pick = get_model_output(player2_model, player2_trump,picks_log,2);
	fprintf(': Picks %s & %s',convert_index_to_rsp_string(player1_pick),...
        convert_index_to_rsp_string(player2_pick));
    picks_log(end+1,:) = [player1_pick, player2_pick];
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
function result = compare_picks(pick1,pick2,player1_trump,player2_trump)
    if pick1 == pick2
        result = [0 0 1]; % tie
    elseif pick1 > pick2
        result = [1 0 0]; % first pick wins
    else
        result = [0 1 0]; % 2nd pick wins
    end
    result = check_if_result_is_doubled(result,...
        pick1,player1_trump,pick2,player2_trump);
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
function out = get_model_output(model_name, trump, log, player_number)
    narginchk(1,4)
    switch model_name
        case 'random guess'
            out = random_guess(3); % 3 for rock, paper, and scissors
        case 'weight trump'
            out = weighted_trump(trump);
        case 'opposite to opponent"s most frequent'
            out = opposite_to_opponents_freq(trump, log, player_number);
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
