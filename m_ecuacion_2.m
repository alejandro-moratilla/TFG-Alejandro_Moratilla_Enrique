function [array_aux,m_aux,m_mean]=m_ecuacion_2(temperaturas,Voc_todas,Isc_todas,Ns,array_Tc,array_medias,error_temperatura,pintar_graficas,modulo_a_calcular)
%Programa para calcular el factor de idealidad m segunda parte, mas exacto
%Para una Tc determinada, representa Voc frente al neperiano de Isc 
%Como, aproximadamente: Voc=Ns·m·kTc/q·Ln(Isc/I0)
%Tiene que salir una recta. La pendiente es, aproximadamente, Ns·m·kTc/q. Se puede despejar m.
%Se necesita que las medidas sean para Tc iguales
%Calcula distintos valores del factor de idealidad en funcion de la temp

for i=1:1:length(array_Tc)
    %Se inicializa el indice y se ponen a 0 los arrays
    indice=1;     
    Voc_array=0;
    Isc_array=0;
    
    for j=1:1:length(temperaturas)
        if temperaturas(j)>=array_Tc(i)-error_temperatura && temperaturas(j)<=array_Tc(i)+error_temperatura
            Voc_array(indice)=Voc_todas(j);
            Isc_array(indice)=log(Isc_todas(j));
            indice=indice+1;
        end
    end
    
    if indice>2 %Minimo tiene que haber dos puntos para pintar la recta
        %Se realiza el ajuste por minimos cuadrados
        pol = polyfit(Isc_array,Voc_array,1);   
        Voc_ajust=polyval(pol,Isc_array);

        %Se realiza el plot
        if pintar_graficas==1
            figure;
            plot(Isc_array,Voc_array,Isc_array,Voc_ajust);
            title(['Voc frente al neperiano de Isc mas ajuste a temperatura ',num2str(array_Tc(i)),' C']);
            xlabel('Isc');
            ylabel('Voc');
            legend('Puntos de la ecuacion','Recta ajustada');
        end

        %Se calcula la pendiente
        pendiente=pol(1);

        %Se calcula el factor de idealidad
        Vt=0.02585*(273+array_medias(i))/300;
        m(i)=pendiente/(Ns*Vt);
    else
        disp(['Pocos valores no se puede calcular la pendiente con ese error para T=',num2str(array_Tc(i)),' C']);
        m(i)=0;
    end
end
    %Se calcula la media de los factores de idealidad
    valor=0;
    indicex=0;
    for z=1:1:length(m)
        if m(z)~=0
            valor=valor+m(z);
            indicex=indicex+1;
    end
    m_mean=valor/indicex;
    
    %Se representa m teorica para comparar
    switch modulo_a_calcular
        case 1
            m_teo=1.8;
        case 2
            m_teo=4.8;
        case 3
            m_teo=3.2;
        case 4
            m_teo=1.7;
        case 5
            m_teo=1.2;
        case 6
            m_teo=1.2;
        case 7
            m_teo=1.8;
        case 8
            m_teo=1.5;
        case 10
            m_teo=1.4;
        otherwise
            m_teo=0;
    end
    %Se calcula el error de la media de m menos m teorico
    error_m=m_mean-m_teo;
    
    %Se eliminan los ceros del vector m y del array_Tc se eliminan las
    %temperaturas
    ind=1;
    for i=1:1:length(m)
        if m(i)~=0
            m_aux(ind)=m(i);
            array_aux(ind)=array_Tc(i);
            ind=ind+1;
        end
    end
    end
