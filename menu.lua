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

function draw_menu()
    cls(134)
    y=000;?"                                ",0,y,1
    y=y+6;?" = tf ========================= ",0,y,1
    y=y+6;?"                                ",0,y,133
    y=y+6;?"  █                             ",0,y,136
    y=y+5;?"  █    █                        ",0,y
    y=y+5;?"  █ █ █                         ",0,y
    y=y+5;?"  █ █ █ █                       ",0,y
    y=y+5;?"  █ █ █ █ █                     ",0,y
    y=y+5;?"  █ █ █ █ █    █                ",0,y
    y=y+5;?"  █ █ █ █ █ █ █ █               ",0,y
    y=y+6;?"  21 22 24 25 26 27 28 29 30 .  ",0,y,129
    y=y+6;?"                                ",0,y
    y=y+6;?" TO BURST?!",print(" ai bubble",0,y,1),y,133
    y=y+6;?" BY GAL PASTERNAK & TJ MICHAEL  ",0,y
    y=y+6;?"                                ",0,y

    if flr((t() * 2) % 2) == 0 then
        print("press ❎ to start", 32, 105, 1)
    end
end