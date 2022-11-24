clear
%varaible inputs for the simluation
ratio_SD=0.30;
N = 40;
v = 0.01;
v_SD=0.001;
T=100;
%calling the function simluation and getting an array of infected
%individuals
%index of the array represent the time
Ninfected=simlulation2(ratio_SD,v,v_SD,N,T);

obj=@(x)computeError(x,Ninfected,T);
LB=0;
UB=7;
X0=0.1;

%finds the best expontial beta value that fits this data
[betaFit, Efit]=fmincon(obj,X0,[],[],[],[],LB,UB);

%getting the value of the mode using value of beta  
for i=1:T
    Exp_model_results(i)=exp(betaFit*i);
end


%plotting the model and the data for visual representation
figure(1);
clf;
plot(Ninfected)
hold on
plot(Exp_model_results)
