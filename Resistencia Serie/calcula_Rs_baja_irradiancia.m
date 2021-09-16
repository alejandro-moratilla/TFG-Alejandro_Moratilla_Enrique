%function [Rs_low]=calcula_Rs_baja_irradiancia(silicio_amorfo,silicio_cristalino,modulo_a_calcular)
%Calcula el valor de la resistencia serie en condiciones estandar(200 W/m2 y 25ºC)

%Se calcula la pendiente Rs
%pendiente_Rs=(Voc_stc-Vm_stc)/(0-Im_stc);
for modulo_a_calcular=1:1:10
%Caso 1: Se separan modulos de silicio amorfo
% if modulo_a_calcular==1 || modulo_a_calcular==4 || modulo_a_calcular==5 || modulo_a_calcular==6 || modulo_a_calcular==10
%     pendiente_Rs=[101.0212,16.8997,6.3273,5.7757,16.198]; %Modulos 1,4,5,6,10
%     Rs=[35.935,4.361,0.479,1.226,1.94];
% else
%     pendiente_Rs=[7.795,102.5732,9.697]; %Modulos 2,3,9
%     Rs=[3.019,28.555,3.993];
% end


%Caso 2: Se separan modulos de silicio amorfo y silicio cristalino
if modulo_a_calcular==1 || modulo_a_calcular==4 || modulo_a_calcular==10
    pendiente_Rs=[101.0212,16.8997,16.198]; %Modulos 1,4,10
    Rs=[35.935,4.361,1.94];
elseif  modulo_a_calcular==2 || modulo_a_calcular==3 || modulo_a_calcular==9
    pendiente_Rs=[7.795,102.5732,9.697]; %Modulos 2,3,9
    Rs=[3.019,28.555,3.993];
elseif modulo_a_calcular==5 || modulo_a_calcular==6
        pendiente_Rs=[6.3273,5.7757]; %Modulos 5,6
        Rs=[0.479,1.226];
end

kk=polyfit(pendiente_Rs,Rs,1);
Rsi=polyval(kk,pendiente_Rs);
%figure;
plot(pendiente_Rs,Rs,'x',pendiente_Rs,Rsi);
title('Ajuste de pendiente Rs y Rs teorica a recta');
legend('Puntos Teoricos','Recta Ajustada');

% % %Valores para caso 1
% switch modulo_a_calcular
%         case 1
%             Valor=1;
%         case 2
%             Valor=1;
%         case 3
%             Valor=2;
%         case 4
%             Valor=2;
%         case 5
%             Valor=3;
%         case 6
%             Valor=4;
%         case 9
%             Valor=3;    
%         case 10
%             Valor=5;
%         otherwise
%             Valor=1;
%     end

%Valores para caso 2
switch modulo_a_calcular
        case 1
            Valor=1;
        case 2
            Valor=1;
        case 3
            Valor=2;
        case 4
            Valor=2;
        case 5
            Valor=1;
        case 6
            Valor=2;
        case 9
            Valor=3;    
        case 10
            Valor=3;
        otherwise
            Valor=1;
    end


%Rs_stc=a*pendiente_Rs + b; donde a y b son los coeficientes del ajuste a una recta obtenidos con el polyfit (kk)
Rs_low(indice)=kk(1)*pendiente_Rs(Valor) + kk(2);
a(indice)=kk(1);
b(indice)=kk(2);
indice=indice+1;
end
