function out = weighted_trump(trump)
% weighted_trump guess: 2/3 change to use trump
not_trump_output = find([1,2,3] ~= trump);

lottery = randi(6,1);
if lottery < 5 % if 
    out = trump;
elseif lottery == 5
    out = not_trump_output(1);
else
    out = not_trump_output(2);
end