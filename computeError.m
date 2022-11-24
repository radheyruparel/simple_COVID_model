function E=computeError(beta,Ninfected,T)

%%getting data for values of beta
for i=1:T
    Exp_model_results(i)=exp(beta*i);
end
%computing the lost funtion at at each time frame
E=sum((Ninfected-Exp_model_results).^2)
