clear
%varaible inputs for the simluation
N=100;
v=0.01;
T=100;
%calling the function simluation and getting an array of infected
%individuals
%index of the array represent the time
Ninfected=simluation1(N,v,T)

obj=@(x)computeError(x,Ninfected,T);
LB=0;
UB=0.3;
X0=0.001;

%finds the best expontial beta value that fits this data
[betaFit, Efit]=fmincon(obj,X0,[],[],[],[],LB,UB);

%getting the value of the mode using value of beta  
for i=1:T
    Exp_model_results(i)=exp(betaFit*i);
end

%figure(1);
%clf;
%plot(beta_values,E)

%plotting the model and the data for visual representation
figure(2);
clf;
plot(Ninfected)
hold on
plot(Exp_model_results)
