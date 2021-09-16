%function [Rp_stc]=calcula_Rp_stc(silicio_amorfo,modulo_a_calcular)
%Calcula el valor de la resistencia paralelo en condiciones estandar(1000 W/m2 y 25ºC)

%En primer lugar se calcula la pendiente de la resistencia paralelo
%pendiente_Rp_modulos=(0-Vm_stc)/(Isc_stc-Im_stc);
%Se calcula la constante de la resistencia paralelo
%Cp_modulos=Rp_teo/pendiente_Rp_modulos;
for modulo_a_calcular=1:1:10
%Se separan modulos de silicio amorfo
if modulo_a_calcular==1 || modulo_a_calcular==4 || modulo_a_calcular==5 || modulo_a_calcular==6 || modulo_a_calcular==10
    pendiente_Rp_modulos=[373.6989,35.8932,41.8033,38.4294,62.938]; %Modulos 1,4,5,6,10
    Rp_teorica=[950,120,125,155,200];
else
    pendiente_Rp_modulos=[34.813,320.0497,47.500]; %Modulos 2,3,9
    Rp_teorica=[60,615,100];
end


kk=polyfit(pendiente_Rp_modulos,Rp_teorica,1);
Rp_teorica_i=polyval(kk,pendiente_Rp_modulos);
plot(pendiente_Rp_modulos,Rp_teorica,'x',pendiente_Rp_modulos,Rp_teorica_i)
title('Ajuste de pendiente Rp y Cp(Rp/Pendiente Rp) a recta');
legend('Puntos Teoricos','Recta Ajustada');

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

%Como CP=Rp_stc/pendiente_Rp ==> Rp_stc=Cp*pendiente_Rp
Rp_stc(indice)=kk(1)*pendiente_Rp_modulos(Valor) + kk(2);
matriz_Rp_stc(indice,1)=kk(1)';
matriz_Rp_stc(indice,2)=kk(2)';
indice=indice+1;


end