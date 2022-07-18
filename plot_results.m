% plot results
fig_half, 
subplot(211)
plot(cumsum(results))
final_score = sum(results);
legend_text_player1 = ['Player 1 - ',player1_model,...
    ' model, Score = ',num2str(final_score(1))];
legend_text_player2 = ['Player 2 - ',player2_model,...
    ' model, Score = ',num2str(final_score(2))];
legend_text_ties = ['Ties = ',num2str(final_score(end))];
lgd = legend(legend_text_player1,legend_text_player2,legend_text_ties,...
    'Location', 'best');
title(lgd,'Results') 
if final_score(1) > final_score(2)
    title_text = 'Winner is player 1!';
elseif final_score(1) < final_score(2)
    title_text = 'Winner is player 2!';
else
   title_text = 'Tie!'; 
end
disp(['Final score: ', num2str(final_score),' ',title_text])
title(title_text), xlabel('Round (#)'), ylabel('Score (points)')
subplot(212)
cum_results = cumsum(results);
plot(cum_results(:,1)-cum_results(:,2))
title('Player 1 vs Player 2'), 
xlabel('Round (#)'), ylabel('Player 1 score vs Player 2 score (points)')
grid