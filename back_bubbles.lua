back_bubbles = {}
next_back_bubble_time = 0

function update_back_bubbles()
    next_back_bubble_time -= 1

    if next_back_bubble_time <= 0 then
        add(back_bubbles, { x = 64 + rnd(60) - 30, y = 128, vx = rnd(2) - 1, vy = -2 })
        next_back_bubble_time = 10
    end

    for bubble in all(back_bubbles) do
        bubble.x += bubble.vx
        bubble.y += bubble.vy

        if bubble.y < 0 then
            del(back_bubbles, bubble)
        end
    end
end

function draw_back_bubbles()
    for bubble in all(back_bubbles) do
        circfill(bubble.x, bubble.y, 2, 7)
    end
end