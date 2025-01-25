menu_won = false
leaving_menu = true

function init_menu()
    --for o=0,15 do
        --pal(o,o+128,1)
    --end
        
    --poke(0x5f2e,1) 
end

function update_menu()
    if btnp(🅾️) or btn(❎) then
        do_transition()
        leaving_menu = true
        --start_game()
    end

    if leaving_menu and during_transition and not transition_in then
        leaving_menu = false
        start_game()
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

    if flr(t() * 9)%2 == 0 then
        title_color = 1
    else
        title_color = 136
    end

    if true == menu_won then
        cls(134)
        y=000;?"                                ",0,y,1
        y=y+6;?" █ tf ████████████ ",0,y,1
        y=y+6;?"                                ",0,y
        y=y+5;?"  █             ",0,y,136
        y=y+5;?"  █             ",0,y,136
        y=y+5;?"  █             ",0,y,136
        y=y+5;?"  █           ",0,y,136
        y=y+5;?"  █             ",0,y,136
        y=y+5;?"  █ █            ",0,y,136
        y=y+5;?"  █ █ █               ",0,y,136
        y=y+6;?"  38 39 40 42 43 44 45 46 47 .  ",0,y,129
        y=y+6;?"                                ",0,y
        y=y+6;?" of mankind?!",print(" the end",0,y,title_color),y,133
        y=y+6;?" BY GAL PASTERNAK & TJ MICHAEL  ",0,y
        y=y+6;?"                                ",0,y
        y=y+6;?" at 20:00 july 6th 2038, an em- ",0,y
        y=y+6;?" ployee of the north american   ",0,y
        y=y+6;?" aerospace defense command gave ",0,y
        y=y+6;?" an ai chatbot  from LLUNAai a- ",0,y
        y=y+6;?" cess to the usa missle defense ",0,y
        y=y+6;?" command netwrok through an un- ",0,y
        y=y+6;?" secured terminal used to...    ",0,y
        return
    end

    draw_graph()


    y=000;?"                                ",0,y,1
    y=y+6;?" █ tf ████████████ ",0,y,1
    y=y+6;?"                                ",0,y,133
    y=y+41;?"  21 22 24 25 26 27 28 29 30 .  ",0,y,129
    y=y+6;?"                                ",0,y
    y=y+6;?" TO BURST?!",print(" ai bubble",0,y,title_color),y,133
    y=y+6;?" BY GAL PASTERNAK & TJ MICHAEL  ",0,y
    y=y+6;?"                                ",0,y 
    y=y+6;?" ceo OF LLUNAai sAMELON fRUSK ( ",0,y
    y=y+6;?" AN ai TRAINED ON THE SOCIAL M- ",0,y
    y=y+6;?" -EDIA POSTS OF eLON mUSK & sAM ",0,y
    y=y+6;?" aLTMAN fRIED). aNNOUNCED MASS- ",0,y 
    y=y+6;?" -IVE QUARTERLY LOSSES FOR T... ",0,y 

    if flr((t() * 2) % 2) == 0 then
        print("press ❎ to start", 32, 120, 1)
    end
end