using Gtk, Graphics

spacing = 30
bg_color = [0, .51, 0.78]

c = @GtkCanvas(400, 400)
win = GtkWindow(c, "Canvas")
@guarded draw(c) do widget
    ctx = getgc(c)

    w = ctx.surface.width
    h = ctx.surface.height

    iterations = (ceil(w / spacing) + 1) * (ceil(h / spacing) + 1)

    draw_background(ctx, w, h)
    draw_pattern(ctx, spacing, iterations, w)
end
show(c)

function draw_background(ctx, w, h)
    rectangle(ctx, 0, 0, w, h)
    set_source_rgb(ctx, bg_color[1], bg_color[2], bg_color[3])
    fill(ctx)
end

function draw_pattern(ctx, spacing, iterations, w)
    x, y = 0, 0
    set_line_width(ctx, 10)
    for i=1:iterations
        if rand() > .5
            move_to(ctx, x, y+spacing)
            line_to(ctx, x+spacing, y)
        else
            move_to(ctx, x, y)
            line_to(ctx, x+spacing, y+spacing)
        end
        set_source_rgb(ctx, 1, 1, 1)
        stroke(ctx)
        x += spacing
        if x > w
            x = 0
            y += spacing
        end
    end
end
