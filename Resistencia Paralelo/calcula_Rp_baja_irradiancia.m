%function [Rp_low]=calcula_Rp_baja_irradiancia(silicio_amorfo,modulo_a_calcular)
%Calcula el valor de la resistencia paralelo en condiciones NOTC(800 W/m2 y 46ºC)

%En primer lugar se calcula la pendiente de la resistencia paralelo
%pendiente_Rp_modulos=(0-Vm_stc)/(Isc_stc-Im_stc);
%Se calcula la constante de la resistencia paralelo
%Cp_modulos=Rp_teo/pendiente_Rp_modulos;
for modulo_a_calcular=1:1:10
%Caso 1:Se separan modulos de silicio amorfo
if modulo_a_calcular==1 || modulo_a_calcular==4 || modulo_a_calcular==5 || modulo_a_calcular==6 || modulo_a_calcular==10
    pendiente_Rp_modulos=[1929.9,198.2781,218.8989,153.8272,390.2993]; %Modulos 1,4,5,6,10
    Rp_teorica=[3401.8,506.76,512.76,371.24,924.18];
else
    pendiente_Rp_modulos=[99.0169,942.7661,337.7778]; %Modulos 2,3,9
    Rp_teorica=[159.08,1351.8,450];
end

% %Caso 2:Se separan modulos de silicio amorfo y silicio cristalino
% if (silicio_amorfo==0) && (silicio_cristalino==0)
%     pendiente_Rp_modulos=[1929.9,198.2781,390.2993]; %Modulos 1,4,10
%     Cp_modulos=[0.492,0.605,0.512];
% elseif silicio_amorfo==1
%     pendiente_Rp_modulos=[99.0169,942.7661,337.7778]; %Modulos 2,3,9
%     Cp_modulos=[0.606,0.652,0.296];
% elseif silicio_cristalino==1
%     pendiente_Rp_modulos=[218.8989,153.8272]; %Modulos 5,6
%     Cp_modulos=[0.571,1.008];
% end

kk=polyfit(pendiente_Rp_modulos,Rp_teorica,1);
Rp_teorica_i=polyval(kk,pendiente_Rp_modulos);
plot(pendiente_Rp_modulos,Rp_teorica,'x',pendiente_Rp_modulos,Rp_teorica_i)
title('Ajuste de pendiente Rp y Cp(Rp/Pendiente Rp) a recta');
legend('Puntos Teoricos','Recta Ajustada');

%Valores para caso 1
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
            Valor=3;
        case 6
            Valor=4;
        case 9
            Valor=3;    
        case 10
            Valor=5;
        otherwise
            Valor=1;
end

% %Valores para caso 2
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
%             Valor=1;
%         case 6
%             Valor=2;
%         case 9
%             Valor=3;    
%         case 10
%             Valor=3;
%         otherwise
%             Valor=1;
% end
    

%Como CP=Rp_stc/pendiente_Rp ==> Rp_stc=Cp*pendiente_Rp
Rp_low(indice)=kk(1)*pendiente_Rp_modulos(Valor) + kk(2);
matriz_Rp_low(indice,1)=kk(1)';
matriz_Rp_low(indice,2)=kk(2)';
indice=indice+1;
end