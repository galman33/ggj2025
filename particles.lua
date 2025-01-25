particles = {}

function update_particles()
    for particle in all(particles) do
        particle.x += particle.vx
        particle.y += particle.vy

        particle.vx += particle.ax
        particle.vy += particle.ay

        if particle.x < -10 or particle.y < -10 or particle.x > 128 + 10 or particle.y > 128 + 10 then
            del(particles, particle)
        end
    end
end

function draw_particles()
    for particle in all(particles) do
        circfill(particle.x, particle.y, particle.radius, particle.color)
    end
end

-- x, y, vx, vy, ax, ay, radius, color
function add_particle(p)
    add(particles, p)
end