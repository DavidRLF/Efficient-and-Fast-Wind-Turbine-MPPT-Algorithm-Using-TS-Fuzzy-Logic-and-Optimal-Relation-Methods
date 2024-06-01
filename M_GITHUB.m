clc; clear all;

%% Version for github

%% Test wind profiles
load('WIND_PERFIL.mat');

%% Parameters of wind turbine
%Static model
Rr = 2.9343;        %Radius [m]
pi = 3.1416; 
Den=1.225;          %Air density standard [kg/m^3]
%Dynamic model
Dg = 0.390;         %Mechanical friction [N-m·s/rad]
Jm = 5*0.1;         %Wind rotor inertia [Kg·m2]
Jg = 5*0.1;         %Electric generator inertia [Kg·m2]

%% PMSG generator
Rs1 = 2.5;          %Stator resistance [Ohms]
La  = 6e-3;         %Armature inductance [H]
Ym  = 0.5;          %Magnetic flux [v·s/rad]
p   = 24;           %pole pairs

%% Three-phase diode bridge
Rs2 =  1e5;         %Snuber resistance [Ohms]
Cs  =  inf;         %Capacitance snuber [F]
Ron = 1e-3;         %On resistor [Ohms]

%% Boost dc-dc converter
Co     = 470e-6;      %Input capacitance [F]
RCo    = 0.01;        %Internal resistance of Co [Ohms]
L      = 80e-3;       %Inductance [H]
Fs1    = 5e3;         %Switching frequency [kHz]
KI     = 0.0195296;   %Integration constant
KP     = 1.0672352;   %Proportional constant 
Ts1    = 1/Fs1;       %Sampling time
io_nom = 22.5;        %Rated output current of the wind system (10kW)
Ki1     = 1/io_nom;   %Current sensor gain (Kh=Ki1)
Dmax   = 1;           %Maximum PWM value

%% Inverter dc-ac
Fc      = 2e3;        %Base frequency of the triangular carrier wave [Hz] 
Fs2     = 60;         %Base frequency of the power grid [Hz]
ws      = 2*pi*Fs2;   %Base frequency of the power grid [rad/s]
vdc     = 500;        %DC bus base voltage [V]
S       = 10e3*3/2;   %Apparent base system power [VA]
VL      = 381.051/2;  %Baseline voltage [rms]
Vf      = VL/sqrt(3); %Base phase voltage [rms]
vdc_ref = 500;        %Desired dc bus voltage [V]
Linv    = 0.0133;     %Inductance [H]
RLinv   = 0.0417;     %Linv internal resistance[Ohms]
Cinv    = 470e-6;     %DC bus capacitor [F]
Ts2     = 1/(4*Fc);   %Sampling time [Seg.]
Ts3     = 1/(100*Fc); %PWM sampling time and other non-controller blocks
Vp      = 1;          %Peak PWM carrier voltage [V]
Kv2     = 500;        %Voltage sensor gain 
Hv_z    = 1/Kv2;
Ki2     = 30;         %Current sensor gain
Hi_z    = 1/Ki2;
Kidq    = 1;          %Current ADC gain
Hidq_z  = 1/Kidq;
Kvdq    = 1;          %Voltage ADC gain
Hvdq_z  = 1/Kvdq;
KI3     = 0.0217732643899006; %Integral voltage controller gain
KP3     = 7.56435818844027;   %Voltage controller proportional gain
KI1     = 0.217806165556525;  %Integral current controller gain
KP1     = 29.8808604912875;   %Proportional gain of the current controller

%% Power grid
VLngrid = 33000/sqrt(3);      %Line voltage to neutral [rms]
Icc     = 5000e6;             %Short circuit current [Arms]  
Fred    = Fs2;                %Frequency [Hz]
In = 1000e3/(1.73*(110));
Icc_calc = In/(5/100);


%% Sample time of MA-MPPT and Oubella-MPPT
Ts6 = 0.02;



