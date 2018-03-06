function bounceTimes = TestBouncingBall(n)
bounceTimes = zeros(n,15);
for i = 1:n
    bounceTimes(i,:) = BouncingBall;
end
