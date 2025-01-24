-- Funny questions and "AI"-like answers
questions = {
    { "why do birds fly?", "because walking takes \ntoo long." },
    { "why is the sky blue?", "it's shy and doesn't want to show its real color." },
    { "can fish sweat?", "only during underwater yoga." },
    { "why do cows moo?", "they forgot the lyrics to the song." },
    { "how do trees use wi-fi?", "they log in." },
    { "why do stars twinkle?", "they're trying to get your attention." },
    { "can you eat a clock?", "yes, but it's very \ntime-consuming." },
    { "why do bananas curve?", "they're avoiding straight paths to keep life exciting." },
    { "what's the speed of dark?", "faster than light when you turn off the switch." },
    { "why don't chairs fly?", "they're afraid of heights." }
}

sequence_chars = {
    { "❎", ❎ },
    { "🅾️", 🅾️ },
    { "⬆️", ⬆️ },
    { "⬇️", ⬇️ },
    { "⬅️", ⬅️ },
    { "➡️", ➡️ }
}

is_on_menu = true

current_question = nil
question_start_time = 0

sequence_length = 6
sequence = {}
sequence_index = 1

total_time = 5
time_left = total_time

timer_on = false
finished = false

animate_bubble2 = false

function _init()
    reset_question()
    reset_sequence()
end

function reset_question()
    bubble1_y = 128
    bubble2_y = 128 * 1.5

    bubble1_t = 9999

    bubble1_shown = false
    bubble2_shown = false

    bubble1_text_to_show = 0
    bubble2_text_to_show = 0

    animate_bubble2 = false

    current_question = rnd(questions)

    question_start_time = 9999
end

function reset_sequence()
    sequence = {}
    for i = 1, sequence_length do
        add(sequence, rnd(sequence_chars))
    end
    sequence_index = 1
end

function _update()
    if is_on_menu then
        update_menu()
        return
    end

    if finished and (btnp(❎) or btnp(🅾️)) then
        reset_question()
        reset_sequence()
        time_left = total_time
        timer_on = false
        finished = false
    end

    if timer_on and not finished then
        if btnp(❎) or btnp(🅾️) or btnp(⬆️) or btnp(⬇️) or btnp(⬅️) or btnp(➡️) then
            if btnp(sequence[sequence_index][2]) then
                sequence_index += 1
                if sequence_index > #sequence then
                    animate_bubble2 = true
                    finished = true
                end
            else
                sequence_index = 1
            end
        end
    end

    update_back_bubbles()

    if bubble1_y > 35 then
        bubble1_y -= 10
    else
        if not bubble1_shown then
            bubble1_t = t()
            bubble1_shown = true
        end
    end

    if bubble1_shown and t() > bubble1_t + 1.5 then
        animate_bubble2 = true
    end

    if animate_bubble2 then
        if bubble2_y > 70 then
            bubble2_y -= 10
        else
            if not bubble2_shown then
                bubble2_shown = true

                question_start_time = t() + 0.25
            end
        end
    end

    if bubble1_shown and bubble1_text_to_show < 1 then
        bubble1_text_to_show += 1 / 30
    end

    if t() > question_start_time then
        timer_on = true
    end

    local target = (sequence_index - 1) / #sequence
    if bubble2_text_to_show < target then
        bubble2_text_to_show += 1 / 30
        if bubble2_text_to_show > target then
            bubble2_text_to_show = target
        end
    elseif bubble2_text_to_show > target then
        bubble2_text_to_show -= 1 / 30
        if bubble2_text_to_show < target then
            bubble2_text_to_show = target
        end
    end

    if timer_on then
        time_left -= 1 / 30
    end
end

function _draw()
    if is_on_menu then
        draw_menu()
        return
    end

    cls(130)

    draw_back_bubbles()

    local y = sin(t() * 1) * 2
    draw_text_bubble(current_question[1], bubble1_text_to_show, 15, bubble1_y + y, false)
    draw_text_bubble(current_question[2], bubble2_text_to_show, 15, bubble2_y + y, true)

    print("hello ggj 2025", 35 + sin(t()) * 10, 5, rnd(15))

    if timer_on and not finished then
        -- draw timer
        rectfill(0, 124, 128, 128, 6)
        rectfill(0, 124, 128 * time_left / total_time, 128, 11)

        -- draw sequence
        local sequence_w = #sequence * 10

        for i = 1, #sequence do
            local c = 7
            if i < sequence_index then
                c = 11
            end
            print(sequence[i][1], (128 - sequence_w) / 2 + (i - 1) * 10, 110, c)
        end
    end

    if finished then
        print("❎ next", 50, 110, 7)
    end
end

function draw_text_bubble(txt, t_to_show, x, y, side)
    local bubble_w = 80
    local bubble_h = 20
    local bubble_h_half = bubble_h / 2

    local c = 7
    if (side) c = 11
    circfill(x + bubble_h_half, y + bubble_h_half, bubble_h_half, c)
    circfill(x + bubble_h_half + bubble_w, y + bubble_h_half, bubble_h_half, c)
    rectfill(x + bubble_h_half, y, x + bubble_w + bubble_h_half, y + bubble_h, c)

    --local txt_speed = 30
    --local n = max(min(flr((t() - start_time) * txt_speed), #txt), 0)
    local n = t_to_show * #txt
    local txt_sub = sub(txt, 1, n)
    print(txt_sub, x + 7, y + 4, 0)

    local tip_y = y + bubble_h_half

    if side then
        local tip_x = x + bubble_w + 5
        line(tip_x + 5, tip_y + 11, tip_x + 8, tip_y + 11, c)
        line(tip_x + 7, tip_y + 12, tip_x + 9, tip_y + 12, c)
        line(tip_x + 8, tip_y + 13, tip_x + 10, tip_y + 13, c)
    else
        local tip_x = x + 1
        line(tip_x + 5, tip_y + 11, tip_x + 8, tip_y + 11, c)
        line(tip_x + 4, tip_y + 12, tip_x + 6, tip_y + 12, c)
        line(tip_x + 3, tip_y + 13, tip_x + 5, tip_y + 13, c)
    end
end