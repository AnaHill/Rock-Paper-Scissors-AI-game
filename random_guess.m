function out = random_guess(number_of_choices)
% Random guess
if nargin < 1 || isempty(number_of_choices)
    number_of_choices = 3; % default 3 for rock, paper, and scissors
end
out = randi(number_of_choices,1);
% rounds = 10000; out = randi(3,rounds,1);figure, histogram(out), hold all, line([1 3],[round(rounds/3),round(rounds/3)])

end