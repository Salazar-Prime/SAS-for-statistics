A = [5 10 7 8];
B = [7 10 12 8];
C = [10 18 11 14];
D = [10 14 11 9];
obs = [A B C D];
clc
fprintf('\nOBS | %f\n',mean(obs))

fprintf('\nA   | %f  || Asub   | %f\n',mean(A), mean(obs) - mean(A))
fprintf('\nB   | %f  || Bsub   | %f\n',mean(B), mean(obs) - mean(B))
fprintf('\nC   | %f || Csub   | %f\n',mean(C), mean(obs) - mean(C))
fprintf('\nD   | %f || Dsub   | %f\n',mean(D), mean(obs)s - mean(D))