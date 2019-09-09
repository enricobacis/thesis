clear
%read csv data
data = csvread("exp_data.csv", 1, 0);
%number of points
n = [2:1:10];

%insert here dollars to ether exchange (1 for dollars)
doToE = 223;

%cost of contract deployment
contract_deployment_cost = -data(4,4);
%owner cost
owner_cost = (-data(:,1)-contract_deployment_cost)/doToE;
%active shareholder cost
sh_act_cost = -data(:,2)/doToE;
%passive shareholder cost
sh_pass_cost= -data(:,3)/doToE;

%creating the plot
figure();
plot(n, owner_cost, ':o');
hold on;
plot(n, sh_act_cost, ':s');
hold on;
plot(n, sh_pass_cost, ':*');
grid off;
legend("Owner", "Active shareholder","Average shareholder", 'Location','best');
title("ITYT Ethereum cost");
xlabel("number of shareholders [n]");
if (doToE == 1)
    ylabel("cost [$]");
else
    ylabel("cost [ether]");
    %scientific notatio on Y axis
ax = gca;
ax.YAxis.Exponent = -2;
end