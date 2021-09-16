function variacion_m_temperatura_2(temperaturas,m_stc,m_stc_2)
%La funcion observa la variacion del factor de idealidad m con la
%temperatura

%Se crea el array de la variacion de T y el array m_stc
for i=1:1:length(temperaturas)
    m_var(i)=m_stc*(temperaturas(i)+273)/(25+273);
    m_var_2(i)=m_stc_2*(temperaturas(i)+273)/(25+273);
end


%Se dibuja la variacion de m con respecto a T con las dos formas
figure;
plot(temperaturas, m_var_2);
hold on;
plot(temperaturas, m_var);
hold off;
title('Variacion del factor de idealidad(m) con respecto la temperatura');
xlabel('Tc');
ylabel('m');
legend('m_{Bowden}','m_{calcula optimos}');