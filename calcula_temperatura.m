function [matriz,array_Tc,array_medias]=calcula_temperatura(temperaturas)
%Calcula el array de las temperaturas por grupos que se utilizan en m_ecuacion_2
%Tambien calcula la media de cada conjunto de temperaturas

%Se crea matriz vacia para ver resultados
for x=1:1:9
    for y=1:1:8
        matriz(x,y)=NaN; %Para que no haya problemas con la media
    end
end

%Se crea el array copia de array temperaturas
for yw=1:1:length(temperaturas)
    copia_temperaturas(yw)=temperaturas(yw);
end

%Se inicializan indices
indice2=1;
indice4=1;
indice_matriz=1;
for i=1:1:length(copia_temperaturas)
    array=0;
    indice=1;
    
    array(1)=copia_temperaturas(i);
    for j=1:1:length(copia_temperaturas)
        if fix(copia_temperaturas(i))==fix(copia_temperaturas(j)) && i~=j && copia_temperaturas(i)~=0
        %if abs(copia_temperaturas(i)-copia_temperaturas(j))<3 && i~=j && copia_temperaturas(i)~=0 %%%%%%%%%%MODIFICAR%%%%%%%%%%%
            indice=indice+1;
            array(indice)=temperaturas(j);
            copia_temperaturas(j)=0;
        end
    end
    copia_temperaturas(i)=0;
    
    %Matriz para observar que grupos coge  %%%%%%%%%%%SOLO PARA PROBAR%%%%
    if length(array)>1
        for zw=1:1:length(array)
            matriz(indice_matriz,zw)=array(zw);
        end
        indice_matriz=indice_matriz+1; %Se incrementa la fila de la matriz
        
        %Se guardan los valores medios de cada grupo
        array_medias(indice4)=mean(array);
        indice4=indice4+1;
    end
    
    
    %Calcular la media del array y coger el mas cercano a la media
    if indice>2 %Cuantos en la lista (2-4) razonable-----------------------
        error=abs(mean(array)-array(1)); %media/mediana/otra opcion
        valor=array(1);
        for w=2:1:length(array)
            if abs(mean(array)-array(w))<error
                valor=array(w);
                error=abs(mean(array)-array(w));
            end
        end
        array_Tc(indice2)=valor;
        %Hay que aproximarlo al valor que mas se acerque del array, porque 
        %tiene que estar en temperaturas o repetir u valor en caso de que el total de valores fuera par
        indice2=indice2+1;
    end
end

%Colocarlos por temperatura array_Tc
for i=1:1:length(array_Tc)
    for j=i+1:1:length(array_Tc)
        if array_Tc(i)>array_Tc(j)
            aux=array_Tc(i);
            array_Tc(i)=array_Tc(j);
            array_Tc(j)=aux;
        end
    end
end

%Colocarlos por temperatura array_medias
for i=1:1:length(array_medias)
    for j=i+1:1:length(array_medias)
        if array_medias(i)>array_medias(j)
            aux=array_medias(i);
            array_medias(i)=array_medias(j);
            array_medias(j)=aux;
        end
    end
end

end