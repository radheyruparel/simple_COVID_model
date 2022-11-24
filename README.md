# Modeling the spread of infectious diseases

<i>NOTE Code directory: File name simluation1 represents a function that models the non-social distancing simulation on a 1000x1000 pixel grid and the function results in an output of an array storing the number of infected individuals.</i>

-<i>File name modeling_results_simluation1 finds the best exponential fit for the result simluation1</i>

-<i>Similarly, file name simluation2 represents a function that models the social distancing simulation on a 1000x1000 pixel grid and the function results in an output of an array storing the number of infected individuals.</i>

-<i>File name modeling_results_simluation2 finds the best exponential fit for the result simluation2</i>

-<i>File name: computeError computes the error (Loss function) from the exponential model of modeling_results_simluation1 and the actual results of the simluation1 or simluation2.</i>

The inspiration for our final project came from this current pandemic of COVID-19 which has affect our everyday lives. We are asked to practice social distancing, through staying 6 feet apart from strangers, don’t visit public places, and only leave our homes for essential purpose such as getting food or emergencies.  In this project we will be using this issue and simulate how COVID-19 and other infectious diseases spreads throughout a population. 

This virus was originating in Wuhan, China and its impact resulted in infection of the populations worldwide. Modelling the spread of this virus, provides us with prediction of individuals getting infected in near future. Such predictions are important for prevention of harmful outcomes and segment regions which have widespread of infection. Through such predictions government and health organization can allocate resources when and where required, to better help the community. 

The virus is spread through the nose or mouth droplets from the infected individual can cling to surfaces and objects, and when a healthy individual comes into the contact with those surfaces that person is infected. Therefore, the infection results when a healthy individual comes in very near proximity of the infected individual. Hence, we are asked to practice social distancing as much as possible. Through this project we also want to evaluate the extend which the social distancing is helpful and result in prevention of the infection. Therefore in this project we have created two different simulations when the given population does not practice social distancing and one where it does practice social distancing. 

When there a simulation model, we require some parameters and variables which needs to stay constant, for better comparison of the simulation of model with social distancing and other without. Therefore, it was required that variables such as time (T=300 frames, each frame can be associated with a day when applying in real-life context), speed of non/social distancing individuals (v=3 pixel/frame), and number of individuals (N=1000) remained constant throughout all the simulation. This parameters and variables need to remain constant, as these variables would influences the results and make it hard to conduct comparisons.  
 
 ![image](https://user-images.githubusercontent.com/6331985/203686927-a92f469f-a208-4e89-b15e-faac332cf95e.png)

Figure 1: Social distancing factors

For better evaluation of the social distancing we introduced 2 more variables to the simulation. The variables is the speed of the individuals practicing social distancing (v_SD =0.3 pixel/frame). In the figure 1, the arrows represent the velocity vectors for each dot, assume the dots to be individuals. As show in the figure 1, some of the dots have a smaller arrows, meaning that they are travelling at reduced velocity (v_SD), furthermore these dots are practicing social distancing. These individuals travel at 1/10th the speed compared to non-social distancing individual. Lowering speed results in more time for the dots to travel the required distance in order perform to collide, and there will more missed opportunity of collision. As result this will limiting interactions of individuals in the simulation. Therefore, through such concepts we were able to implement social distancing of individuals to our second simulation. To better able to compare the result and evaluate the effectiveness of social distancing. We introduced variable which allows a decided percentage of individuals  from the whole population to move at the speed specially for individuals practicing social distancing (ratio_SD). We will varying the value of the variable ratio_SD, in order to observe the effect when more and more people from the population practice social distancing. The code of the simulation is able to implement such concepts, by first creating a fixed grid a fixed space (1000x1000 pixel), in order for these dots to move around. Then N number of dots are placed randomly in this given space, this done through the help of random function. Next, they are given a random direction vector, by using rand function to decides its angle for movement. Then using the value of the angle generated using random function, the dots movement of the dot is divided into the components of x and y, cos(angle) for x and sin(angle) for y. Then such dots move around based on the velocity (v or v_SD) assigned to them and according to the direction assigned, in increments of x and y components each frame

![image](https://user-images.githubusercontent.com/6331985/203687098-1b836b95-1233-4fd0-a864-81f87aac955e.png)

Figure 2: Process of counting collisions

As mentioned before, infection result due to a healthy individual being in very close proximity of the infected individual. Through using the illustration above assume the dots to be individuals of the simulation, in a fixed space (1000x1000 pixel). Blue dot represents an healthy individual and red represents an infected individual. Currently, assume the dots are moving at same speed in random directions in given fixed space. As there are moving in random direction, at an instant in long period of the simulation, there is a high chance that two dots can be in each other’s proximity. Therefore at each instant (frame) the simulation calculate how far each dot is apart they are from others. Another parameter is the value of threshold (threshold=10 pixel). If the distance between the two dots is more than apart than value of the threshold the program will not count the collision. If the distance apart is equal or less than the threshold one collision is counted, as shown in the snapshot of the code above. The collision always results in infection of healthy individual, due to being in very close proximity from the infected individual. Therefore our simulation if counting the collision between healthy individual and infected individual over a period (300 frames). In simulation we have certain assumptions that one individual is already infected in the population at the start. The infected remain infected for the duration of the simulation, there is neither recovery nor reinfection, which doesn’t represent how the COVID-19 virus behaves. However, these assumptions are made for simplicity of results.  

![image](https://user-images.githubusercontent.com/6331985/203687266-4146c443-0891-4450-b107-b44da85ea7f8.png)


Figure 3: Implementation of Exponential model

Through the simulation we have a vector which stores the number of detected collisions at every frame. Using this data the main part of the program plots the number of infected people vs time, shown in figure 3. This graph shows an example where people don’t practice social distancing. All the viral infection spread in a given populations are exponential. Hence, in the to implement an exponential model on the data derived from the simulation. This implemented exponential model will give us number of infected individuals at every instant of time. Based on the equation shown, which is programmed as shown,  the precise the beta value we can find, more accurate the results are from our model. The better our model will align with the trends resulted from the simulation. 

![image](https://user-images.githubusercontent.com/6331985/203687360-3849b7e6-e667-4fd3-a574-32d9131e4dc5.png)

Figure 4: Fitting beta values of the model

For our exponential model to accurately represent the trend from the simulated data, we require precise values. The red double head arrows shown in figure 4 represent errors between the implemented exponential model and data generated from the simulation. The program should able to find the value for beta which minimizes these error between the model and actual data. In order to this we will be using mean squared error technique, the formula is shown above. The program will calculate the error between the model and actual data at each instant of time, over a range of beta values. For all the value of time (each frame) the program squares the error between the model and actual data and sum those values of each individual beta value. The program compare these summation of error, and select the beta value with least summation of error. We can do this Matlab using Fmincon recipe learned in class, as shown one example in figure 4. Hence, we had to create a function we calculate the summation of error square for a particular beta value. Next this function was assigned to X object for the Fmincon, and the boundaries for the value of beta were placed, in order for the code to determine the perfect beta value in that range. 

 ![image](https://user-images.githubusercontent.com/6331985/203687561-204ad9d4-8b73-4c4f-9196-2773814d6a1b.png)

Figure 5: Comparison of result of the simulation

The figure above showcases the infection spread in the given population at the end of T (time) of both the simulation created. On right side of the figure, it illustrates the result whe 80% of the population are social distancing. Through such results we are able to evaluate  the difference in infection rates and number of infected individuals after time T, between social distancing and not social distancing.

![image](https://user-images.githubusercontent.com/6331985/203687631-d0e65c84-b04a-4b42-87cc-4a6702961a95.png)

The graph plots the ratio of individuals from population practicing social distancing (ratio_SD) against the betaFit values derived from the code. These betaFit values represent the values with the least summation of error between our model and the actual data created from the simulation. These beta value mostly accurately aligns with the trend generated by the data of infection in relation to time. As shown above first bar indicates 0 for ratio_SD, meaning that population is not practicing social distancing and it contains highest betaFit value. A high betaFit value occurs where there is a very high rate of infection spread in the population. This aligns with our predictions as more individuals are likely to come in contact with another infected individual. The trend which is observed from this graph is that as the values of ratio_SD increase the associated betaFit values are decreasing. The number of individuals practicing social distancing increases as the values of ratio_SD increase, due to which the rate of infection spread decreases, hene we observe a decrease in betaFit values. 

![image](https://user-images.githubusercontent.com/6331985/203688026-203847f3-ebda-4e93-b062-0a62d0f2df73.png)

The second graph plots ratio of individuals from population practicing social distancing (ratio_SD) against the number of infected individuals at the end of time T (Ninfected). As shown above first bar indicates when the population is not practicing social distancing which has the is the highest number of infected individuals. A similar trend is observed, that as the ratio_SD is increasing the associated number of infected individuals decreases. This elaborates that when high part of the population practice social distancing, number of infection cases decrease significantly.   

In conclusion, the project demonstrates the promotes preventative measure of social distancing, especially during pandemics which we are now currently facing. Through this project we are able to conclude that practice social distancing we definitely derecree the rate of infection and total number of infected cases. Also if huge part to the population does not practice social distancing the consequences could be severe. According to the current there is no vaccine or specific treatments, so the best we can do is to avoid the infection in order prevent spread and promote health. The project was mainly focused on COVID-19, however the simulation can be applied to other infectious diseases. The further application of this project can used to investigate other infectious, and factors such recovery, and reinfection  to more accurate analysis the problems and find solutions. 


Bibliography  
•	Coronavirus Disease 2019 (COVID-19). (n.d.). Retrieved May 03, 2020, from https://www.cdc.gov/coronavirus/2019-ncov/index.html

•	Rettner, Rachael. “Instead of Just Flattening the COVID-19 Curve, Can We 'Crush' It?” LiveScience, Purch, 3 Apr. 2020, www.livescience.com/can-covid-19-be-crushed.html.

•	Lin, Qianying, et al. “A Conceptual Model for the Coronavirus Disease 2019 (COVID-19) Outbreak in Wuhan, China with Individual Reaction and Governmental Action.” International Journal of Infectious Diseases, vol. 93, 2020, pp. 211–216., doi:10.1016/j.ijid.2020.02.058.

•	Thunström, Linda, et al. “The Benefits and Costs of Using Social Distancing to Flatten the Curve for COVID-19.” Journal of Benefit-Cost Analysis, 2020, pp. 1–27., doi:10.1017/bca.2020.12.











