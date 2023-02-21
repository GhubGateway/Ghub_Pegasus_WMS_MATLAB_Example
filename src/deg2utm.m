function deg2utm(Lat,Lon)
    % -------------------------------------------------------------------------
    % https://www.mathworks.com/matlabcentral/fileexchange/10915-deg2utm?status=SUCCESS
    %
    % Copyright (c) 2006, Rafael Palacios
    % All rights reserved.
    %
    % deg2utm(Lat,Lon)
    %
    % Description: Function to convert lat/lon scalars into UTM coordinates (WGS84).
    % Some code has been extracted from UTM.m function by Gabriel Ruiz Martinez.
    %
    % Inputs:
    %    Lat [str]: Latitude.   Degrees.  +ddd.dddddd  WGS84
    %    Lon [str]: Longitude.  Degrees.  +ddd.dddddd  WGS84
    %
    % Outputs:
    %    utm.txt:
    %    x [utme], y [utmn], utmzone
    %
    % Author: 
    %   Rafael Palacios
    %   Universidad Pontificia Comillas
    %   Madrid, Spain
    % Version: Apr/06, Jun/06, Aug/06, Aug/06
    % Aug/06: fixed a problem (found by Rodolphe Dewarrat) related to southern 
    %    hemisphere coordinates. 
    % Aug/06: corrected m-Lint warnings.
    %   rlj
    %   Feb/23: Handle string scalar input and write output to a text file.
    %-------------------------------------------------------------------------
    
    % Argument checking
    %
    error(nargchk(2, 2, nargin));  %2 arguments required
    
    la = str2double(Lat);
    fprintf('la: %.06f\n', la);
    lo = str2double(Lon);
    fprintf('lo: %.06f\n', lo);

    sa = 6378137.000000 ; sb = 6356752.314245;

    %e = ( ( ( sa ^ 2 ) - ( sb ^ 2 ) ) ^ 0.5 ) / sa;
    e2 = ( ( ( sa ^ 2 ) - ( sb ^ 2 ) ) ^ 0.5 ) / sb;
    e2cuadrada = e2 ^ 2;
    c = ( sa ^ 2 ) / sb;
    %alpha = ( sa - sb ) / sa;             %f
    %ablandamiento = 1 / alpha;   % 1/f

    lat = la * ( pi / 180 );
    lon = lo * ( pi / 180 );

    Huso = fix( ( lo / 6 ) + 31);
    S = ( ( Huso * 6 ) - 183 );
    deltaS = lon - ( S * ( pi / 180 ) );

    if (la<-72), Letra='C';
    elseif (la<-64), Letra='D';
    elseif (la<-56), Letra='E';
    elseif (la<-48), Letra='F';
    elseif (la<-40), Letra='G';
    elseif (la<-32), Letra='H';
    elseif (la<-24), Letra='J';
    elseif (la<-16), Letra='K';
    elseif (la<-8), Letra='L';
    elseif (la<0), Letra='M';
    elseif (la<8), Letra='N';
    elseif (la<16), Letra='P';
    elseif (la<24), Letra='Q';
    elseif (la<32), Letra='R';
    elseif (la<40), Letra='S';
    elseif (la<48), Letra='T';
    elseif (la<56), Letra='U';
    elseif (la<64), Letra='V';
    elseif (la<72), Letra='W';
    else Letra='X';
    end

    a = cos(lat) * sin(deltaS);
    epsilon = 0.5 * log( ( 1 +  a) / ( 1 - a ) );
    nu = atan( tan(lat) / cos(deltaS) ) - lat;
    v = ( c / ( ( 1 + ( e2cuadrada * ( cos(lat) ) ^ 2 ) ) ) ^ 0.5 ) * 0.9996;
    ta = ( e2cuadrada / 2 ) * epsilon ^ 2 * ( cos(lat) ) ^ 2;
    a1 = sin( 2 * lat );
    a2 = a1 * ( cos(lat) ) ^ 2;
    j2 = lat + ( a1 / 2 );
    j4 = ( ( 3 * j2 ) + a2 ) / 4;
    j6 = ( ( 5 * j4 ) + ( a2 * ( cos(lat) ) ^ 2) ) / 3;
    alfa = ( 3 / 4 ) * e2cuadrada;
    beta = ( 5 / 3 ) * alfa ^ 2;
    gama = ( 35 / 27 ) * alfa ^ 3;
    Bm = 0.9996 * c * ( lat - alfa * j2 + beta * j4 - gama * j6 );
    x = epsilon * v * ( 1 + ( ta / 3 ) ) + 500000;
    y = nu * v * ( 1 + ta ) + Bm;

    if (y<0)
       y=9999999+y;
    end

    utmzone = sprintf('%02d%c',Huso,Letra);

    fid = fopen('./utm.txt','w');
    fprintf(fid,'%7.2f\n',x);
    fprintf(fid,'%7.2f\n',y);
    fprintf(fid,'%s\n', utmzone);
    fclose(fid);
    type('./utm.txt');

end
