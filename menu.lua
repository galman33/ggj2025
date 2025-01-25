function init_menu()
    --for o=0,15 do
        --pal(o,o+128,1)
    --end
        
    --poke(0x5f2e,1) 
end

function update_menu()
    if btnp(🅾️) or btn(❎) then
        is_on_menu = false
    end
end


bars = { 1, 2, 3, 4, 5, 6, 7, 1, 2 }

function draw_bar(xa,ya,sizea)
    for i=0,6 do
        if i<=sizea then
            ya=ya+5;?"  ",xa,ya,136
        else
            ya=ya+5;?"█",xa,ya,136
        end
    end
end

graph_iteration=0   
slow=6
function draw_graph()
    for i=0,8 do
        size=abs(sin((graph_iteration/slow+i)%8/7))*7
        draw_bar(8+12*i,11,size)
    end          
    graph_iteration=graph_iteration+1
end    

function draw_menu()
    cls(134)
    draw_graph()
    y=000;?"                                ",0,y,1
    y=y+6;?" = tf ========================= ",0,y,1
    y=y+6;?"                                ",0,y,133
    y=y+41;?"  21 22 24 25 26 27 28 29 30 .  ",0,y,129
    y=y+6;?"                                ",0,y
    y=y+6;?" TO BURST?!",print(" ai bubble",0,y,1),y,133
    y=y+6;?" BY GAL PASTERNAK & TJ MICHAEL  ",0,y
    y=y+6;?"                                ",0,y

    if flr((t() * 2) % 2) == 0 then
        print("press 🅾️ to start", 32, 105, 1)
    end
end