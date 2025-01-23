bubble1_y = 128
bubble2_y = 128 * 4

function _init()
end

function _update()
    update_back_bubbles()

    if bubble1_y > 30 then
        bubble1_y -= 10
    end

    if bubble2_y > 55 then
        bubble2_y -= 10
    end
end

function _draw()
    cls(130)

    draw_back_bubbles()

    local y = sin(t() * 1) * 2
    draw_text_bubble("hello", 0.5, 20, bubble1_y + y, false)
    --draw_text_bubble("bye", 2, 20, bubble2_y + y, true)
    draw_text_bubble("12345678901234567890", 2, 20, bubble2_y + y, true)

    print("hello ggj 2025", 35 + sin(t()) * 10, 5, rnd(15))
end

function draw_text_bubble(txt, start_time, x, y, side)
    local bubble_w = 80

    local c = 7
    if (side) c = 11
    circfill(x + 5, y + 5, 5, c)
    circfill(x + 5 + bubble_w, y + 5, 5, c)
    rectfill(x + 5, y, x + 5 + bubble_w, y + 10, c)

    local txt_speed = 15
    local n = max(min(flr((t() - start_time) * txt_speed), #txt), 0)
    local txt_sub = sub(txt, 1, n)
    print(txt_sub, x + 5, y + 3, 0)

    if side then
        local tip_x = x + bubble_w - 2
        line(tip_x + 5, y + 11, tip_x + 8, y + 11, c)
        line(tip_x + 7, y + 12, tip_x + 9, y + 12, c)
        line(tip_x + 8, y + 13, tip_x + 10, y + 13, c)
    else
        local tip_x = x - 2
        line(tip_x + 5, y + 11, tip_x + 8, y + 11, c)
        line(tip_x + 4, y + 12, tip_x + 6, y + 12, c)
        line(tip_x + 3, y + 13, tip_x + 5, y + 13, c)
    end
end