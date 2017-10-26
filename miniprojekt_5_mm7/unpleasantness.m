clear all
close all
clc

%Scaling the unpleasantness of sounds according to the BTL model:
%ratio-scale representation and psychoacoustical analysis
%Ellermeier et al.: BTL-scaling the unpleasantness of sounds ACTA ACUSTICA UNITED WITH ACUSTICA
%Vol. 90 (2004)

%Table I. Cumulative preference matrix (N = 60). Note. Absolute
%frequencies are given with which the sound in the row was judged
%to be more unpleasant than the sound in the column. Sounds: 1 -
%truck, 2 - brake, 3 - train, 4 - water, 5 - boat, 6 - jackhammer, 7 -
%mower, 8 - crash, 9 - mixer, 10 - vent.

unpleasant=[
0 9 16 45 56 5 29 6 24 33
51 0 34 58 58 13 46 30 39 50
44 26 0 55 57 9 48 37 38 55
15 2 5 0 38 2 17 6 6 20
4 2 3 22 0 3 6 3 3 12
55 47 51 58 57 0 58 53 55 57
31 14 12 43 54 2 0 16 17 41
54 30 23 54 57 7 44 0 40 52
36 21 22 54 57 5 43 20 0 43
 27 10 5 40 48 3 19 8 17 0];

%Sounds: 
%1 - truck
%2 - brake
%3 - train
%4 - water
%5 - boat
%6 - jackhammer
%7 - mower
%8 - crash
%9 - mixer
%10 - vent.

%laver en matrix, p, med "probabilities". Ifølge slideshowet fra mm7,
%regnes det ud, vha. freq/N, hvor freq er frequencies, og N er antallet af
%testpersoner.
p = unpleasant/60;

%Definerer variabler til Weak Stochastic Transitivity, Moderate Stochastic
%Transitivity og Strong Stochastic Transitivity. Yderligere har jeg en
%counter, der tæller hvor mange gange, første if statement er sand. Med
%andre ord, hvor mange datapunkter, der ikke sammenlignes (1000-720 = 280)
WST = 0;
MST = 0;
SST = 0;
Count = 0;
%måske en ide med en counter her.
for a = 1:10;
    for b = 1:10;
        for c = 1:10;
            if (a~=b)&&(b~=c)&&(a~=c);
                if p(a,b)>=0.5 && p(b,c) >=0.5;
                    Count = Count+1;
                    if p(a,c)<0.5;
                    WST = WST+1;
                    end
                        if p(a,c) < min(p(a,b),p(b,c));
                        MST = MST+1;
                        end
                            if p(a,c) < max(p(a,b),p(b,c));
                                SST = SST+1;
                            end
                end
            end
        end
    end
end


              


%laver et cell-array på størrelse med antallet af søjler
A = {[1];[2];[3];[4];[5];[6];[7];[8];[9];[10]};


%Her regnes: p=parametre, chistat = chi squared test(output: X^2  frihedsgrader  p-værdi || tester goodness of fit)
%u = scale values (samme værdi i BLT som parametrene p), lL_eba/lL_sat = log
%likelihoods of model specified in A and of the saturated model, fit =
%returns the fitted values, covar = the covariance
%
%inputttet i fOptiPt er vores frequency, unpleasant, og vores cell array, A
[p,chistat,u,lL_eba,lL_sat,fit,cova]=fOptiPt(unpleasant,A);


%Her regnes 95% konfidensintervaller af diagonalen i vores covarians
conf_int= 1.96*sqrt(diag(cova));
%errorbar plotter figuren
errorbar(u,conf_int, 'O')
xlabel('Soundnumber')
ylabel ('Estimated unpleasantness [95% CI]')
xlim([0 11])
ylim([0 1.2])