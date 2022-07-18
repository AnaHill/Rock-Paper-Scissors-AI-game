function out = find_most_popular_index(data, only_one_output)
% returns only one index if 
narginchk(1,2)
% default: return only one value, not multiple even though they 
if nargin < 2 || isempty(only_one_output)
    only_one_output = 1;
end
% N = histcounts(opponents_log); % how many each
% https://se.mathworks.com/matlabcentral/answers/12636-how-can-i-count-the-number-of-times-a-number-appear-in-a-vector
[~, ~, uidx] = unique(data(:));
counts = accumarray(uidx, 1);
most_popular_indexes = find(counts == max(counts));
% function out = find_most_popular_index(data, only_one_output)
% fprintf('%d appears %d times\n', [u, counts].');

if length(most_popular_indexes) > 1 && only_one_output < 2
    % if multiple most popular indexes are found, but only one is wanted,
    % pick randomly one of them
    temp = randi([1 length(most_popular_indexes)],1,1);
    out = most_popular_indexes(temp);
else 
    out = most_popular_indexes;
end



end