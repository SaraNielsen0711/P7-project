%Multidimensional scaling lecture:
clear all
close all
clc

facial=[
0.00	4.05	8.25	5.57	1.15	2.97	4.34	4.90	6.25	1.55	1.68	6.57	3.93
4.05	0.00	2.54	2.69	2.67	3.88	8.53	1.31	1.88	4.84	5.81	7.43	4.51
8.25	2.54	0.00	2.11	8.98	9.27	11.87	2.56	0.74	9.25	7.92	8.30	8.47
5.57	2.69	2.11	0.00	3.78	6.05	9.78	4.21	0.45	4.92	5.42	8.93	3.48
1.15	2.67	8.98	3.78	0.00	2.34	7.12	5.90	4.77	2.22	4.34	8.16	1.60
2.97	3.88	9.27	6.05	2.34	0.00	1.36	5.18	5.45	4.17	4.72	4.66	4.89
4.34	8.53	11.87	9.78	7.12	1.36	0.00	8.47	10.20	5.44	4.31	1.57	9.18
4.90	1.31	2.56	4.21	5.90	5.18	8.47	0.00	2.63	5.45	3.79	6.49	6.05
6.25	1.88	0.74	0.45	4.77	5.45	10.20	2.63	0.00	7.10	6.58	9.77	6.55
1.55	4.84	9.25	4.92	2.22	4.17	5.44	5.45	7.10	0.00	1.98	4.93	4.12
1.68	5.81	7.92	5.42	4.34	4.72	4.31	3.79	6.58	1.98	0.00	4.83	3.51
6.57	7.43	8.30	8.93	8.16	4.66	1.57	6.49	9.77	4.93	4.83	0.00	12.65
3.93	4.51	8.47	3.48	1.60	4.89	9.18	6.05	6.55	4.12	3.51	12.65	0.00
];

% 1 Grief at death of mother
% 2 Savoring a coke
% 3 Very pleasant surprise
% 4 Maternal love-baby in arms
% 5 Physical exhaustion
% 6 Something wrong with plane
% 7 Anger at seeing dog beaten
% 8 Pulling hard on seat of chair
% 9 Unexpectedly meets old boy friend
% 10 Revulsion
% 11 Extreme pain
% 12 Knows plane will crash
% 13 Light sleep 


%her regnes stress ud for dimension 1-7. Det skal bruges til at plotte
%scree-plottet.
[Y1,stress1,disparities1] = mdscale(facial,1);
 [Y2,stress2,disparities2] = mdscale(facial,2);
 [Y3,stress3,disparities3] = mdscale(facial,3);
[Y4,stress4,disparities4] = mdscale(facial,4);
 [Y5,stress5,disparities5] = mdscale(facial,5);
 [Y6,stress6,disparities6] = mdscale(facial,6);
 [Y7,stress7,disparities7] = mdscale(facial,7);
%plotter scree
 scree = plot([1:7],[stress1 stress2 stress3 stress4 stress5 stress6 stress7])
 xlabel('Dimensions');
 ylabel('Stress');
 
 %det her var et step Christian tilføjede, som jeg tror er ligemeget.
 %Vector Y og Y2 er ens.
 dissimilarities = squareform(facial);
 [Y,stress2,disparities] = mdscale(dissimilarities,2);

 %Laver nu MDS plot. Variablen 'str' ændrer skriftstørrelsen på labels og
 %akser. Først beder vi om at plotte alle punkterne med en aterisk '*'. Vi
 %vælger at plotte vector Y2 ((søjle 1), (søjle 2)). Derefter vælger vi
 %hvert enkelt datapunkt, og tilføjer den rigtige betegnelse, (fx
 %'Revulsion')
 str = 14;
figure = plot(Y2(:,1), Y2(:,2), '*')
text(Y2(1,1),Y2(1,2) ,'Grief at death of mother', 'FontSize',str)
text(Y2(2,1),Y2(2,2) ,'Savoring a coke', 'FontSize',str)
text(Y2(3,1),Y2(3,2) ,'Very pleasant surprise', 'FontSize',str)
text(Y2(4,1),Y2(4,2) ,'Maternal love-baby in arms', 'FontSize',str)
text(Y2(5,1),Y2(5,2) ,'Physical exhaustion', 'FontSize',str)
text(Y2(6,1),Y2(6,2) ,'Something wrong with the plane', 'FontSize',str)
text(Y2(7,1),Y2(7,2) ,'Anger at seeing dog beaten', 'FontSize',str)
text(Y2(8,1),Y2(8,2) ,'Pulling hard on seat of chair', 'FontSize',str)
text(Y2(9,1),Y2(9,2) ,'Unexpectedly meets old boy friend', 'FontSize',str)
text(Y2(10,1),Y2(10,2) ,'Revulsion', 'FontSize',str)
text(Y2(11,1),Y2(11,2) ,'Extreme pain', 'FontSize',str)
text(Y2(12,1),Y2(12,2) ,'Knows plane will crash', 'FontSize',str)
text(Y2(13,1),Y2(13,2) ,'Light sleep', 'FontSize',str)
xlabel('Negativity', 'FontSize', str)
ylabel('Absent-minded', 'FontSize', str)








%Dette her er Shepard-plottet. Koden er eksempelkode fra matlabs egen
%dokumentation under mdscale()
 
%  distances = pdist(Y);
% [dum,ord] = sortrows([disparities(:) dissimilarities(:)]);
% Shepard = plot(dissimilarities,distances,'bo', ...
%      dissimilarities(ord),disparities(ord),'r.-', ...
%      [0 15],[0 15],'k-')
% xlabel('Dissimilarities')
% ylabel('Distances/Disparities')
% legend({'Distances' 'Disparities' '1:1 Line'},...
%        'Location','NorthWest');
