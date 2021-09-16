% function []=representa_Rp_irradiancias(modulo_a_calcular)

% modulo_a_calcular=1

for modulo_a_calcular=1:10

switch modulo_a_calcular
        case 1
            Rp_teorico=[950,950,3401.8];
            G_Rp=[1000,747.4,249.9];
            Rp=[950.31,950.49,3413.7];
            
            k_Rp=0.0086;
        case 2
            Rp_teorico=[60,60,159.08];
            G_Rp=[1000,744.4,244.2];
            Rp=[67.64,56.93,138.12];
            
            k_Rp=0.005;
        case 3
            Rp_teorico=[615,777.86,1351.8];
            G_Rp=[1000,739.5,242.8];
            Rp=[615.36,614.72,1343.53];
            
            k_Rp=0.0039;
        case 4
            Rp_teorico=[120,120,506.76];
            G_Rp=[1000,748.7,152.1];
            Rp=[128.33,130.17,505.13];
            
            k_Rp=0.0081;
        case 5
            Rp_teorico=[125,125,512.76];
            G_Rp=[1000,753.4,152.3];
            Rp=[142.71,126.83,539.77];
            
            k_Rp=0.0078;
        case 6
            Rp_teorico=[155,155,371.24];
            G_Rp=[1000,752.4,151.4];
            Rp=[134.5,146.43,430.47];
            
            k_Rp=0.0035;   
        case 7
            k_Rp=0;
        case 8
            k_Rp=0;
        case 9
            Rp_teorico=[100,100,450];
            G_Rp=[1000,800,200];  
            Rp=[92,103.35,479.22];
            
            k_Rp=0.01;
        case 10
            Rp_teorico=[200,200,924.18];
            G_Rp=[1000,752.2,152.1];
            Rp=[194.14,196.07,827.67];
            
            k_Rp=0.00910;
        otherwise
            Rp_teorico=NaN;
            G_Rp=NaN;
            Rp=NaN;
end

kk=polyfit(G_Rp,Rp,1);
Rpi=polyval(kk,G_Rp);

kkk=polyfit(G_Rp,Rp_teorico,1);
Rpi2=polyval(kkk,G_Rp);

% plot(G_Rp,Rp_teorico,'X',G_Rp,Rp,'O');
% hold on;
% plot(G_Rp,Rpi2,G_Rp,Rpi);
% hold off;
% title(['Rp en funcion de la irradiancia del modulo ',num2str(modulo_a_calcular)]);
% xlabel('G');
% ylabel('Rp');
% legend('Puntos Teoricos','Puntos Calculados','Puntos Teoricos Ajustada','Puntos Calculados Ajustada');


k_Rp_2=0.0064;

Rp_stc=Rp(G_Rp==1000);

for indice_formula=1:length(Rp)
    if G_Rp(indice_formula)<550
        Rp_formula(indice_formula)=Rp_stc*(1+k_Rp*(550-G_Rp(indice_formula))); % 
        Rp_formula_2(indice_formula)=Rp_stc*(1+k_Rp_2*(550-G_Rp(indice_formula))); % 
    else
        Rp_formula((indice_formula))=Rp_stc;
        Rp_formula_2((indice_formula))=Rp_stc;
    end
end


% figure;

plot(G_Rp,Rp_teorico,'X',G_Rp,Rp_formula);
hold on;
plot(G_Rp,Rp_formula_2);
plot(G_Rp,Rpi);
hold off;
title(['Resistencia paralelo en función de la irradiancia. Módulo: ',num2str(modulo_a_calcular)]);
xlabel('G (W/m^2)');
ylabel('Rp (\Omega)');
legend('Puntos Teóricos','Recta ajustada con la fórmula de Peña con K_{Rp} variable','Recta ajustada con la fórmula de Peña con K_{Rp} fijo','Recta ajustada por mínimos cuadrados');

pause;

end