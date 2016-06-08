function   [bopt, solve_time,points,np] = readResult(fname)

fid = fopen(fname,'r');
if fid < 0
    error(['Could not open ',fname,' for input']);
end

for i=1:2
    buffer = fgetl(fid);
end
if(strfind(buffer, 'Optimal Solution Found'))
    bopt = true;
    for i=1:2
        buffer = fgetl(fid);
    end
    tline = fgetl(fid);
    [a,b,c] = strread(tline,'%s %s %f');
    solve_time = c;
    
    for i=1:3
        buffer = fgetl(fid);
    end
    
    for i=1:3
        for j=1:3
            tline = fgetl(fid);
            [a,b,c] = strread(tline,'%f %f %f');
            p(i,j) = c;
        end
    end
    points=p;
   
    for i=1:40
        buffer = fgetl(fid);
    end
    for i=1:3
        for j=1:3
            tline = fgetl(fid);
            [a,b,c] = strread(tline,'%f %f %f');
            np(i,j) = c;
        end
        np(i,:) =np(i,:)/norm(np(i,:)); 
    end
    fclose(fid);
else
    fclose(fid);
    bopt = false;
    points=zeros(3,3);
    np = zeros(3,3);
    solve_time = 0;
end

