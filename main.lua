-- Funny questions and "AI"-like answers
sequence_chars = {
    { "🅾️", 🅾️ },
    { "⬆️", ⬆️ },
    { "⬇️", ⬇️ },
    { "⬅️", ⬅️ },
    { "➡️", ➡️ }
}

face_sprites = { 3, 5, 7 }

is_on_menu = true

current_question = nil
current_question_index = 0
question_start_time = 0

current_face = 3

sequence = {}
sequence_index = 1

total_time = 5
time_left = total_time

timer_on = false
answered = false
finished = false

animate_bubble2 = false
animate_bubble3 = false

bubble2_sound_playing = false

function _init()
    init_menu()

    music(0, 0, 1)

    reset_question()
    reset_sequence()
end

function reset_question()
    bubble1_y = 128
    bubble2_y = 128 * 1.5
    bubble3_y = 128 * 1.5

    bubble1_t = 0
    bubble3_t = 0

    bubble1_shown = false
    bubble2_shown = false
    bubble3_shown = false

    bubble1_text_to_show = 0
    bubble2_text_to_show = 0
    bubble3_text_to_show = 0

    animate_bubble2 = false
    animate_bubble3 = false

    current_question_index += 1
    if current_question_index > #questions then
        current_question_index = 1
    end
    current_question = questions[current_question_index]

    question_start_time = 0

    timer_on = false

    current_face = rnd(face_sprites)
end

function reset_sequence()
    sequence = {}
    local sequence_length = flr((current_question_index - 1) / 2) + 2
    sequence_length = min(sequence_length, 20)
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
        answered = false
        finished = false
    end

    if timer_on and not answered then
        if btnp(❎) or btnp(🅾️) or btnp(⬆️) or btnp(⬇️) or btnp(⬅️) or btnp(➡️) then
            if btnp(sequence[sequence_index][2]) or (sequence[sequence_index][2] == 🅾️ and btnp(❎)) then
                sequence_index += 1
                if sequence_index > #sequence then
                    animate_bubble3 = true
                    bubble3_t = t()
                    timer_on = false
                    answered = true
                end
            else
                sequence_index = 1

                sfx(4, 2)
            end
        end
    end

    update_back_bubbles()

    local bubble1_y_target = 14
    if bubble1_y > bubble1_y_target then
        bubble1_y -= 10

        if bubble1_y < bubble1_y_target then
            bubble1_y = bubble1_y_target
        end
    else
        if not bubble1_shown then
            bubble1_t = t()
            bubble1_shown = true

            -- start typing sound
            sfx(0, 1)
        end
    end

    if bubble1_shown and t() > bubble1_t + 1.5 then
        animate_bubble2 = true
    end

    if animate_bubble2 then
        local bubble2_y_target = 52
        if bubble2_y > bubble2_y_target then
            bubble2_y -= 10

            if bubble2_y < bubble2_y_target then
                bubble2_y = bubble2_y_target
            end
        else
            if not bubble2_shown then
                bubble2_shown = true

                question_start_time = t() + 0.25
            end
        end
    end

    if animate_bubble3 and t() > bubble3_t + 0.25 then
        local bubble3_y_target = 89
        if bubble3_y > bubble3_y_target then
            bubble3_y -= 10
            if bubble3_y < bubble3_y_target then
                bubble3_y = bubble3_y_target
            end
        else
            if not bubble3_shown then
                bubble3_shown = true

                sfx(0, 1)
            end
        end
    end

    if bubble1_shown and bubble1_text_to_show < 1 then
        bubble1_text_to_show += 1 / 30

        if bubble1_text_to_show > 1 then
            bubble1_text_to_show = 1

            -- stop typing sound
            sfx(-1, 1)
        end
    end

    if bubble3_shown and bubble3_text_to_show < 1 then
        bubble3_text_to_show += 1 / 30
        if bubble3_text_to_show > 1 then
            finished = true

            -- stop typing sound
            sfx(-1, 1)
        end
    end

    if not answered and bubble2_shown and t() > question_start_time then
        timer_on = true
    end

    if bubble2_shown then
        local target = (sequence_index - 1) / #sequence
        local should_play_sound = false

        if bubble2_text_to_show < target then
            bubble2_text_to_show += 1 / 30
            if bubble2_text_to_show > target then
                bubble2_text_to_show = target
            end

            should_play_sound = true
        elseif bubble2_text_to_show > target then
            bubble2_text_to_show -= 1 / 30
            if bubble2_text_to_show < target then
                bubble2_text_to_show = target
            end

            --should_play_sound = true
        end

        if should_play_sound != bubble2_sound_playing then
            if should_play_sound then
                sfx(3, 1)
            else
                sfx(-1, 1)
            end
            bubble2_sound_playing = should_play_sound
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

    cls(13)

    draw_back_bubbles()

    local y = sin(t() * 1) * 2
    draw_text_bubble(current_question[1], bubble1_text_to_show, 15, bubble1_y + y, false)
    spr(current_face, 3, bubble1_y + y + 21, 2, 2)
    draw_text_bubble(current_question[2], bubble2_text_to_show, 15, bubble2_y + y, true)
    spr(1, 111, bubble2_y + y + 21, 2, 2)
    draw_text_bubble(current_question[3], bubble3_text_to_show, 15, bubble3_y + y, false)
    spr(current_face, 3, bubble3_y + y + 21, 2, 2)

    local title = "lluna ai trial edition"
    local title_x = 22
    local title_y = 4
    local title_colors = { 10, 11, 12 }
    for i = 1, #title do
        local letter_color = title_colors[flr(i * 0.5 + t() * 10) % #title_colors + 1]
        title_x = print(title[i], title_x, title_y + sin(i * 0.1 + t()) * 2, letter_color)
    end

    if timer_on or (answered and t() < bubble3_t + 0.5) then
        -- draw timer
        rectfill(0, 124, 128, 128, 6)
        rectfill(0, 124, 128 * time_left / total_time, 128, 11)

        -- draw sequence
        local max_sequence_in_line = 10
        local spacing_w = 10
        local spacing_h = 10
        local seqeunce_lines = flr((#sequence - 1) / max_sequence_in_line) + 1
        local sequence_h = (seqeunce_lines - 1) * spacing_h
        for j = 0, seqeunce_lines - 1 do
            local sequence_left = min(#sequence - j * max_sequence_in_line, max_sequence_in_line)
            local sequence_w = (sequence_left - 1) * spacing_w

            for i = 0, sequence_left - 1 do
                local c = 7
                local index_in_sequence = (j * max_sequence_in_line) + i + 1
                if index_in_sequence < sequence_index then
                    c = 11
                end
                print(sequence[index_in_sequence][1], (128 - sequence_w) / 2 + i * spacing_w - 4, 110 - sequence_h / 2 + j * spacing_h, c)
            end
        end
    end

    if finished then
        print("🅾️ next", 50, 120, 7)
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
    local txt_offset = 1
    if side then
        txt_offset = -2
    end

    print(txt_sub, x + 9, y + 4 + txt_offset, 0)

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