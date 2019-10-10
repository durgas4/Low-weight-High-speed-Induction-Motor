function IM
% input data.
fprintf('\n -------------------------------------------------------------- \n');
fprintf('\n INPUT THE SPECIATIONS OF THE INDUCTION MOTOR\n');
ph=input('\n no of phases=\n');
p=input('power out KW=\n');
v=input('voltage in volts(line)=\n');
f=input('frequency on hz=\n');
Bav=input('bav in Wb/m2=\n');
ac=input('ac in a/m=\n');
Kw=input('winding factor=\n');
pf=input('power facot=\n');
eff=input('eff of m/c=\n');
N=input('Speed of m/c=\n');
% to find speed
ns=N/60;%rps
%poles
po=(2*f)/ns;
% to find output co-efficient
Co=11*Kw*Bav*ac*10^-3;
fprintf('\noutput coeffieicent = %f \n',Co);

% to find input KVA
Q=p/(eff*pf);
% to find D and L
D=abs((Q/(Co*ns))/1.18)^(1/3);
L=1.18*D;%ventilating ducts are required
%calculate tou
tou=L/1.5;%for low cost design consideration
% to find pole pitch
pp=(pi*D)/po;
%peripheral speed
ps=(pi*D*ns);
fprintf('\n------------------------------------------------- \n');
fprintf('\n DIAMETER AND NET LENGTH OF THE INDUCTION MOTOR \n');
fprintf('\n ------------------------------------------------------------- \n');
fprintf('\n THE DIAMETER OF THE INDUCTIONMOTOR=%.6f METERS \n',D);
fprintf( '\n peripheral speed = %f mps \n' , ps);
%stator design
% flus per pole
flux=Bav*(pi*D*L)/po;
disp(flux)
% turns per phase
Tp=v/(4.44*f*flux*Kw);
% no of stator slots
qs=input('\n no of stator slots per pole per phase= \n');
ss=ph*po*qs;%total stator slots
disp(ss);
yss=(pi*D)/ss;
sp=ss/ph;
sc=6*Tp;
zss=sc/ss;
cs=ss/po;
fprintf('\n THE COIL SPAN OF THE INDUCTIONMOTOR=%.4f \n',cs);
evenno=input('\n IF THE CS VALUE IS EVEN , THANTYPE 2 ELSE ANY OTHER NO= \n');
cs1=2;
if cs1==evenno
 alpha=(1/cs)*180;
  kp=cos((alpha/2)*(pi/180));
  

kd=(sin((qs*alpha/2)*(pi/180)))/(qs*(sin((qs*alpha/4)*(pi/180))));

 kws=kp*kd;
 disp(kws);
end
% conductor size
Is=(p*1e3)/(3*v*eff*pf);
disp(Is);
IsL=sqrt(3)*Is;
fprintf('\n THE STATOR LINE CURRENT OF THE INDUCTION MOTOR=%.4f AMPS \n',IsL);
currentdensity=input('\ncurrent density corresponding to stator line current= \n');
A=Is/4;
Db=input('\nbare diameter in meters =');
as=pi/(4*Db^2);
density=Is/as;
fprintf('\n THE DENSITY OF STATOR CONDUCTOR OF THE INDUCTION MOTOR=%.10f A/M2 \n',density);
d1=input('\n diameter of enamelled conductor CORRESPONDING TO DENSITY in meters = \n');
% slot dimensions
S=zss*as;
sf=input('\nspace factor for the slots= \n');
As=S/sf;
Li=input('\n length of iron = \n');
wts=flux/(1.7*(ss/po)*Li);
Lmts=(2*L)+(2.3*(tou))+0.24;
% flux density in stator teeth
Bmst=flux/((ss/po)*wts*Li);
% flux in stator core
fluxstator=flux/2;
B=input('\n flux density of the stator core in wb/m2= \n');
Asc=fluxstator/B;
dcs=Asc/Li;
dcd=input('core depthin meters = \n');
Bcs=(dcs/dcd)*1.2;
h=input('\nheight of the core in m= \n');
lip=input('\nlip in meters =\n');
wedge=input('\nwedge in meters = \n');
dss=h+lip+wedge;
Do=D+2*dss+2*dcs;
fprintf('\n-----------------------------------------------------------------\n');
fprintf('\n OUTPUT OF THE STATOR DESIGN OF INDUCTION MOTOR \n');
fprintf('\n---------------------------------------------------------- \n');
fprintf('\n THE FLUX PER POLE OF THE INDUCTION MOTOR=%.4f WB \n',flux);
fprintf('\n THE STATOR TURNS PER POLE OF THE INDUCTION MOTOR=%.4f TURNS \n',Tp);
fprintf('\n THE STATOR WINDING FACTOR OF THE INDUCTION MOTOR=%.4f \n ',kws);
fprintf('\n THE STATOR CURRENT OF THE INDUCTION MOTOR=%.4f AMPS \n',Is);
fprintf('\n THE WIDTH OF THE STATOR TEETH OF THE INDUCTION MOTOR=%.4f METERS \n',wts);
fprintf('\n THE LENGTH OF MEAN TURN OF THE INDUCTION MOTOR=%.4f METERS \n',Lmts);
fprintf('\n THE FLUX DENSITY IN STATOR TEETH OF THE INDUCTION MOTOR=%.4f WB \n',Bmst);
fprintf('\n THE DEPTH OF STATOR CORE OF THE INDUCTION MOTOR=%.4f METERS \n',dcs);
fprintf('\n THE OUTER DIAMETER OF STATOR LAMINATIONS OF THE INDUCTION MOTOR=%.4f METERS \n',Do);
fprintf('\n----------------------------------------------------- \n');
% Rotor design
Lg=0.2+2*sqrt(D*L);
fprintf('\n THE LENGTH OF AIR GAP OF ROTOR OF THE INDUCTION MOTOR=%.4f METERS \n',Lg);
Lg1=input('\n if Lg is greater than 0.3 it must be taken as 0.0003 METERS for mm too m conversion = \n');%conversion from mm to m
Dr=D-2*Lg1;
Sr=input('\n rotor slots= \n');
ysr=(pi*Dr)/Sr;
Ib=(6*Is*Tp*kws*pf)/Sr;
rotordensity=input('\n rotor bar current density in A/m2=\n');
ab=Ib/rotordensity;
conductorsize=input('\nconductor size standard= \n');
wsr=input('\n width of rotor slot in meters = \n');
dsr=input('\n depth of rotor slot in meters = \n');
slotpitch=(pi*(Dr-2*wsr))/Sr;
wt=slotpitch-wsr;
fluxdensity=flux/((Sr/po)*Li*wt);
Lb=input('\n length of each bar in meters= \n');
Resistivity=input('\n resisitivity of the rotor= \n');
rb=Resistivity*Lb/ab;
Tclb=Sr*Ib^2*rb*1e6;
fprintf('\n----------------------------------------------------------------------- \n');
fprintf('\n OUTPUT OF THE ROTOR DESIGN OF INDUCTION MOTOR \n ');
fprintf('\n------------------------------------------------------------------ \n');
fprintf('\n THE AIR GAP LENGTH OF ROTOR OF THE INDUCTION MOTOR=%.4f METERS \n',Lg);
fprintf('\n THE DIAMETER OF ROTOR OF THE INDUCTION MOTOR=%.4f METERS \n',Dr);
fprintf('\n THE ROTOR SLOT PITCH OF THE INDUCTION MOTOR=%.4f METERS \n',ysr);
fprintf('\n THE ROTOR BAR CURRENT OF THE INDUCTION MOTOR=%.4f AMPS \n',Ib);
fprintf('\n THE WIDTH OF THE ROTOR TEETH AT THE ROOT OF THE INDUCTION MOTOR=%.4f METERS \n ',wt);
fprintf('\n THE RESISTANCE OF EACH BAR OF THE INDUCTION MOTOR=%.12f OHMS \n',rb);
fprintf('\n THE FLUX DENSITY IN ROTOR TEETH OF THE INDUCTION MOTOR=%.4f WB \n',fluxdensity);
fprintf('\n THE TOTAL COPPER LOSSES IN BARS OF THE INDUCTION MOTOR=%.4f WATTS \n',Tclb);
fprintf('\n------------------------------------------------------------- \n');
% design of end rings .
Ibe=(Sr*Ib)/(pi*po);
currentdensityend=input('\n current density of end ring in A/m2=\n');
ae=Ibe/currentdensityend;
ae1=ae/1e6;
Doer=(Dr-2*wsr);
de=input('\n depth of ring in meters = \n');
Dier=Doer-2*de;
De=(Doer+Dier)/2;
resistivity=input('\n resistivity of the end ring=\n');
re=(resistivity*pi*De)/ae;
CL=2*Ib^2*re*1e3;
Tcl=Tclb+CL;
%rotoroutput=input('rotot output in KW =');
slip=(Tcl/(Tcl+(p*1e3)))*100;
%rotor core
dcr=dcs;
Bcr=input('\n flux density in rotor core in wb/m2 \n ');
Di=Dr-2*wsr-2*dcr;
fprintf('\n------------------------------------------------------ \n');
fprintf('\n OUTPUT OF THE END RING OF INDUCTION MOTOR\n ');
fprintf('\n-------------------------------------------------------------------------- \n');
fprintf('\n THE END RING CURRENT OF THE INDUCTION MOTOR=%.4f AMPS\n ',Ibe);
fprintf('\n THE AREA OF END RING OF THE INDUCTION MOTOR=%.4f SQUARE MILL-METERS\n',ae1);
fprintf('\n THE RESISTANCE OF END RING OF THE INDUCTION MOTOR=%.12f OHMS \n',re);
fprintf('\n THE TOTAL ROTOR COPPER LOSSES OF THE INDUCTION MOTOR=%.4f WATTS \n ',Tcl);
fprintf('\n THE SLIP OF THE INDUCTION MOTOR=%.4f PERCENTAGE \n ',slip);
fprintf('\n THE INNER DIAMETER OF ROTOR LAMINATION OF THE INDUCTION MOTOR=%.4f METERS \n',Di);
fprintf('\n--------------------------------------------------------------------- \n');
% magnetizing current of stator
slotopening=input('\n slot opening = \n');
gaplength=input('\n gap length=\n');
statorratio=slotopening/gaplength;
Kcs=input('\n carters coefficient=\n');
wo=input('wo=');
Kgss=yss/(yss-Kcs*wo);
%rotor
slotopeningrotor=input('\n rotor slot opening= \n');
gaplengthrotor=input('rotor gap opening= \n');
rotorratio=slotopeningrotor/gaplengthrotor;
Kcsr=input('\n rotor carters coefficient= \n');
wo1=input('\nwo1=\n');
Kgsr=ysr/(ysr-Kcsr*wo1);
Kgs=Kgss*Kgsr;
Kgd=input('\n gap concentration factor \n');
Kg=Kgs*Kgd;
Ag=((pi*D)/4)*L;
Bg=1.36*Bav;
Lge=Kg*gaplength;
Atg=800000*Bg*Kg*Lg1;
%stator teeth
Atp=(ss/po)*wts*Li;
Bts=input('\n flux density of stator teeth=\n');
Btss=1.36*Bts;
fprintf('\n THE flux density of the stator teeth OF THE INDUCTION MOTOR=%.4f WB/M2 \n',Btss);
ats=input('\n flux density corresponding to Btss in A/m=\n');
mmfst=ats*dss;
%stator core
Acs=Li*dcs;
Bcs=input('\n flux density of stator core in wb/m2= \n');
Lcs=pi*(D+2*dss+dcs)/(3*po);
atcs=input('\n amper turns of stator in A/m= \n');
Atcs=atcs*Lcs;
%rotor teeth
wts=(pi*(Dr-4*dsr)/Sr)-wsr;
Atr=(Sr/po)*wts*Li;
Btr=input('\n flux density at 1/3 ht in wb/m2= \n');
Btra=1.36*Btr;
atr=input('\n flux density in A/m= \n');
Atrt=atr*dsr;
%rotor core
Alr=Li*dcr;
Brl=input('\n flux density in rotor core= \n');
atsr=input('\n flux density in A/m= \n');
lcr=(pi*(Dr-2*dsr-2*dcr))/(3*po);
Atcr=atsr*lcr;
At1=Atg+mmfst+Atcs+Atrt+Atcr;
Im=(0.427*po*At1)/(kws*Tp);
fprintf('\n------------------------------------------------------------------------------ \n');
fprintf('\n OUTPUT OF NO LOAD CURRENT(MAGNETIZING CURRENT) OF INDUCTION MOTOR \n ');
fprintf('\n-------------------------------------------------------------------------- \n');
fprintf('\n THE MMF REQUIRED FOR AIR GAP OF THE INDUCTION MOTOR=%.4f AMPS \n ',Atg);
fprintf('\n THE MMF REQUIRED FOR STATOR TEETH OF THE INDUCTION MOTOR=%.4f AMPS \n',mmfst);
fprintf('\n THE MMF REQUIRED FOR STATOR CORE OF THE INDUCTION MOTOR=%.4f AMPS \n',Atcs);
fprintf('\n THE MMF REQUIRED FOR ROTOR TEETH OF THE INDUCTION MOTOR=%.4f AMPS \n',Atrt);
fprintf('\n THE MMF REQUIRED FOR ROTOR CORE OF THE INDUCTION MOTOR=%.4f AMPS \n',Atcr);
fprintf('\n THE TOTAL MMF OF THE INDUCTION MOTOR=%.4f AMPS',At1);
fprintf('\n THE TOTAL MAGNETIZING CURRENT PER PHASE OF THE INDUCTION MOTOR=%.4f AMPS \n',Im);
fprintf('\n------------------------------------------------------------------------------------- \n');
%loss component
Vst=input('\n volume of stator teeth in METER,CUBE(M3)= \n');
%iron losses in stator teeth
Wst=Vst*7.6*1e3;
Bst=(pi/2)*Bts;
fprintf('\n THE FLUX DENSITY CORRESPONDING TO STATOR TEETH OF THE INDUCTION MOTOR=%.4fWB/M2 \n',Bst);
Lkg=input('\n corresponding to Bst loss per kg in w= \n');
ILst=Lkg*Wst;
%iron loss in stator core
Vsc=input('\n volume of stator core in METERCUBE(M3)= \n');
wsc=Vst*7.6*1e3;
Bsc=Bcs;
fprintf('\n THE FLUX DENSITY CORRESPONDING TOSTATOR CORE OF THE INDUCTION MOTOR=%.4fWB/M2 \n',Bsc);
Ilc=input('\n iron loss per kg corresponding to flux density=\n');
ILsc=Ilc*wsc;
%totoal iron losses
Il=ILst+ILsc;
Itl=2*Il;
%Friction and windage losses
fwlp=input('\n percentage of friction and windage losses=\n');
fwl=(fwlp/100)*p*1e3;
Tnll=Itl+fwl;
%load current
IL= Tnll/(3*v);
I0=sqrt(IL^2+Im^2);
%power factor
pfo=IL/Im;
phaseangle=acos(pfo)*(180/pi);
%losses and effiency
rs=((resistivity*Tp*Lmts)/As);
CLs=3*IL^2*rs; 
Ip=CL+Itl+fwl+CLs+(p*1e3);
eff1=((p*1e3)/Ip)*100;
% output of the following design
fprintf('\n--------------------------------------------------------------------- \n');
fprintf('\n OUTPUT OF LOSS COMPONENT OFINDUCTION MOTOR \n');
fprintf('\n---------------------------------------------------------------------------- \n');
fprintf('\n THE IRON LOSS IN STATOR TEETH OF THEINDUCTION MOTOR=%.4f WATTS \n',ILst);
fprintf('\n THE IRON LOSS IN STATOR CORE OF THEINDUCTION MOTOR=%.4f WATTS \n',ILsc);
fprintf('\n THE TOTAL IRON LOSSES IN STATOR OFTHE INDUCTION MOTOR=%.4f WATTS \n',Itl);
fprintf('\n THE TOTAL FRICTION AND WINDIAGE LOSSES OF THE INDUCTION MOTOR=%.4fWATTS\n',fwl);
fprintf('\n THE TOTAL NO LOAD LOSSES OF THE INDUCTION MOTOR=%.4f WATTS\n',Tnll);
fprintf('\n THE TOTAL NO LOAD CURRENT PER PHASE OF THE INDUCTION MOTOR=%.4f AMPS \n',I0);
fprintf('\n THE POWER FACTOR OF THE INDUCTION MOTOR=%.4f \n',pfo);
fprintf('\n THE PHASE ANGLE OF NO LOAD CURRENT OF THE INDUCTION MOTOR=%.4fDEGREES\n',phaseangle);
fprintf('\n THE EFFICIENCY AT FULL LOAD OF THE INDUCTION MOTOR=%.4f \n',eff1);
fprintf('\n----------------------------------------------------------------------- \n');

