WST = 0;
MST = 0;
SST = 0;
Count = 0;

for a = 1:6;
    for b = 1:6;
        for c = 1:6;
            if (a~=b)&&(b~=c)&&(a~=c); %avoids comparing the same value (0)
                if p_model(a,b)>=0.5 && p_model(b,c) >=0.5;
                    Count = Count+1;
                    if p_model(a,c)<0.5; %checks for WST violations
                    WST = WST+1; %counts number of violations
                    end
                        %checks for MST violations
                        if p_model(a,c) < min(p_model(a,b),p_model(b,c));
                        MST = MST+1; %counts number of violations
                        end
                            %checks for SST violations
                            if p_model(a,c) < max(p_model(a,b),p_model(b,c));
                                SST = SST+1;%counts number of violations
                            end
                end
            end
        end
    end
end
m2tex('loop.m')