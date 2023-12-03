clear; 
close all;
load mtlb;
for i = 1:4
    figure(i); 
   if i == 1    
       function_draw1('32MTP'); 
   end
    if i == 2    
        function_draw1('33MHP'); 
    end
    if i == 3    
        function_draw1('34MQP'); 
    end
    if i == 4    
        function_draw1('35MMQ'); 
    end
    
end
