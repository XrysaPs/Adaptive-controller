function [dz] = dxWithUncertaintyAdaptive(t,z,Am,B,Br,k,P,gama,array)
if t>=0 && t<1
    r=0;
elseif t>=1 && t<10
    r=0.5;
elseif t>=10 && t<22
    r=0;
elseif t>=22 && t<32
    r=-0.5;
elseif t>=32 && t<45
    r=0;
elseif t>=45 && t<55
    r=1;
elseif t>=55 && t<65
    r=0;
elseif t>=65 && t<75
    r=-1;
elseif t>=75 && t<85
    r=0;
elseif t>=85 && t<95
    r=0.5;
elseif t>=95
    r=0;
end

x=z(1:3);
theta=z(4:6);
xm=z(7:9);

ubl=-k'*x;
fi=[ubl; x(2); x(3)];
dxm=Am*xm+Br*r;
dtheta=gama*fi*(x-xm)'*P*B;
D=1/(1-theta(1));
uad=-theta'*fi;
dx = Am*x+B*D*(uad + (array)'*fi)+Br*r;
dz=[dx; dtheta; dxm];

end

