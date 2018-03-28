function DrawBall(P, pos)

    if P.animate
        % Draw the ball at the current position
        ballPos = pos + P.ballRadius/2;
%         ball = viscircles(ballPos, P.ballRadius, 'Color', P.ballColor, 'LineWidth', 10);
        ball = filledCircle(ballPos, P.ballRadius, 8, P.ballColor);
        % The interval time to update the plot (the lower the slower)
        pause(P.update_time);
        if ~P.leaveTrail
        % Delete the previous ball
            delete(ball);
        end
    end
%     if P.leaveTrail
%         hold on;
%         plot(pos(1), pos(2), 'r.');
%     end
    
end