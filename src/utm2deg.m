function  utm2deg()
    % -------------------------------------------------------------------------
    % https://www.mathworks.com/matlabcentral/fileexchange/10914-utm2deg?s_tid=FX_rc1_behav
    %
    % Copyright (c) 2006, Rafael Palacios
    % All rights reserved.
    %
    % [Lat,Lon] = utm2deg(x,y,utmzone)
    %
    % Description: Function to convert UTM coordinates into Lat/Lon scalars (WGS84).
    % Some code has been extracted from UTMIP.m function by Gabriel Ruiz Martinez.
    %
    % Inputs:
    %    utme [str], utmn [str], utmzone [str].
    %
    % Outputs:
    %    deg.txt:
    %    Lat: Latitude.   Degrees.  +ddd.dddddd  WGS84
    %    Lon: Longitude.  Degrees.  +ddd.dddddd  WGS84
    %
    % Author: 
    %   Rafael Palacios
    %   Universidad Pontificia Comillas
    %   Madrid, Spain
    % Version: Apr/06, Jun/06, Aug/06
    % Aug/06: corrected m-Lint warnings
    %   rlj
    %   Feb/23: Handle string scalar input from text file and write output to a text file.
    %-------------------------------------------------------------------------

    % utm.txt created by deg2utm.m:
    fid = fopen('./utm.txt','r');
    data1 = textscan(fid, '%s', 'Delimiter', '\n');
    data2 = data1{1,:};
    x = str2double(data2(1));
    y = str2double(data2(2));
    utmzone = data2{3,:};
    fclose(fid);
    
    fprintf('x [utme]: %7.2f\n',x);
    fprintf('y [utmn]: %7.2f\n',y);
    fprintf('utmzone: %3s\n', utmzone);

    c=size(utmzone);
    if (c~=3)
        error('utmzone should be a string like "30T"');
    end
 
    zone=str2double(utmzone(1:2));
    fprintf('zone: %.02f\n', zone);

    if (utmzone(3)>'X' || utmzone(3)<'C')
      fprintf('utm2deg: Warning utmzone should be a string like "30T", not "30t"\n');
    end
    if (utmzone(3)>'M')
      hemis='N';   % Northern hemisphere
    else
      hemis='S';
    end
    fprintf('hemis: %s', hemis);


   sa = 6378137.000000 ; sb = 6356752.314245;
  
    %   e = ( ( ( sa ^ 2 ) - ( sb ^ 2 ) ) ^ 0.5 ) / sa;
    e2 = ( ( ( sa ^ 2 ) - ( sb ^ 2 ) ) ^ 0.5 ) / sb;
    e2cuadrada = e2 ^ 2;
    c = ( sa ^ 2 ) / sb;
    %   alpha = ( sa - sb ) / sa;             %f
    %   ablandamiento = 1 / alpha;   % 1/f

    X = x - 500000;

    if hemis == 'S' || hemis == 's'
       Y = y - 10000000;
    else
       Y = y;
    end

    S = ( ( zone * 6 ) - 183 ); 
    lat =  Y / ( 6366197.724 * 0.9996 );                                    
    v = ( c / ( ( 1 + ( e2cuadrada * ( cos(lat) ) ^ 2 ) ) ) ^ 0.5 ) * 0.9996;
    a = X / v;
    a1 = sin( 2 * lat );
    a2 = a1 * ( cos(lat) ) ^ 2;
    j2 = lat + ( a1 / 2 );
    j4 = ( ( 3 * j2 ) + a2 ) / 4;
    j6 = ( ( 5 * j4 ) + ( a2 * ( cos(lat) ) ^ 2) ) / 3;
    alfa = ( 3 / 4 ) * e2cuadrada;
    beta = ( 5 / 3 ) * alfa ^ 2;
    gama = ( 35 / 27 ) * alfa ^ 3;
    Bm = 0.9996 * c * ( lat - alfa * j2 + beta * j4 - gama * j6 );
    b = ( Y - Bm ) / v;
    Epsi = ( ( e2cuadrada * a^ 2 ) / 2 ) * ( cos(lat) )^ 2;
    Eps = a * ( 1 - ( Epsi / 3 ) );
    nab = ( b * ( 1 - Epsi ) ) + lat;
    senoheps = ( exp(Eps) - exp(-Eps) ) / 2;
    Delt = atan(senoheps / (cos(nab) ) );
    TaO = atan(cos(Delt) * tan(nab));
    longitude = (Delt *(180 / pi ) ) + S;
    latitude = ( lat + ( 1 + e2cuadrada* (cos(lat)^ 2) - ( 3 / 2 ) * ...
        e2cuadrada * sin(lat) * cos(lat) * ...
        ( TaO - lat ) ) * ( TaO - lat ) ) * (180 / pi);
    
    fid = fopen('./deg.txt','w');
    fprintf(fid,'%.06f\n', latitude);
    fprintf(fid,'%.06f\n', longitude);
    fclose(fid);
    type('./deg.txt');
    
end
   
