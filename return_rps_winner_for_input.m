function out = return_rps_winner_for_input(input)
% input: 1) rock, 2) paper, 3) scissors
% rock wins scissors, paper wins rock, scissors win paper
if input == 1 % rock
    out = 2;
elseif input == 2 % paper
    out = 3; 
elseif input == 3 % scissors
    out = 1;
else
    error('Not proper input given!')
end

end