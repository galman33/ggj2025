during_transition = false
transition_in = false
transition_out = false
transition_start_time = 0
transition_mid_duration = 0.5

function do_transition()
    during_transition = true
    transition_in = true
    transition_out = false
    transition_start_time = t()
end

function update_transition()
    if during_transition then
        if t() >= transition_start_time + transition_mid_duration and transition_in then
            transition_in = false
            transition_out = true
        elseif t() >= transition_start_time + transition_mid_duration * 2 then
            during_transition = false
            transition_out = false
        end
    end
end

function draw_transition()
    local spacing = 16

    if during_transition then
        for x = -1, 10 do
            for y = -1, 10 do
                local tt = t() - transition_start_time
                if transition_out then
                    tt = transition_mid_duration - (tt - transition_mid_duration)
                end
                --fillp(0b0011001111001100)
                circfill(x * spacing, (y + (x % 2) * 0.5) * spacing, tt * 30, 0)
                fillp()
            end
        end
    end
end