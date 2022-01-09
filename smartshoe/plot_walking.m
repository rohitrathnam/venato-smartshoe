range = 50
t = 1:range;
figure()
hold on
plot(t,f1(1:range))
plot(t,f2(1:range))
plot(t,f3(1:range))
plot(t,f4(1:range))
plot(t,f5(1:range))
legend('FrontInside','Toe','Heelinside','Heeloutside','Frontoutside')
hold off

