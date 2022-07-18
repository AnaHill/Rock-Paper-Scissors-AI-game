function out = opposite_to_opponents_freq(player_trump, log, player_number)
% if log is empty, i.e. during first round, choose trump
if isempty(log)
    out = player_trump;
    return
end

if length(log) < 5 
    % if log is less than 5, choose weighted_trump
    out = weighted_trump(player_trump);
else % find the most popular from te opponent 
    opponent_column = find([1,2] ~= player_number);
    opponents_log = log(:,opponent_column); % opponents plays
    opponents_most_popular = find_most_popular_index(opponents_log,1);
    % find winner for opponents most popular guess
    out = return_rps_winner_for_input(opponents_most_popular);
%     disp(['Opponents most popular index: ',num2str(opponents_most_popular),...
%         ' -> choose: ', num2str(out)])
end


end