function variacion_m_temperatura(m,array_Tc)
%La funcion observa la variacion del factor de idealidad m con la
%temperatura

p=polyfit(array_Tc,m,1);   
m_val=polyval(p,array_Tc);
%Se dibuja la variacion de m con respecto a T con las dos formas
figure;
plot(array_Tc,m);
hold on;
plot(array_Tc,m_val);
hold off;
title('Variacion del factor de idealidad(m) con respecto la temperatura');
xlabel('Tc');
ylabel('m');
legend('m_{diferentes m}','m_{diferentes m ajustada}');


end