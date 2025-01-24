function update_menu()
    if btnp(🅾️) then
        is_on_menu = false
    end
end

function draw_menu()
    cls()
    if flr((t() * 2) % 2) == 0 then
        print("press 🅾️ to start", 30, 60, 7)
    end
end