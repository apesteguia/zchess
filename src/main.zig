const rl = @import("raylib");
const tablero = @import("tablero.zig");
const pieza = @import("pieza.zig");

pub fn main() anyerror!void {
    const screenWidth = 800;
    const screenHeight = 800;
    const PIXEL: i32 = screenHeight / tablero.N;

    rl.initWindow(screenWidth, screenHeight, "zchess");
    defer rl.closeWindow();

    rl.setTargetFPS(10);
    const t = tablero.Tablero.new();

    const peon: rl.Texture = rl.Texture.init("/home/mikel/Escritorio/zchess/src/static/peon.png");
    defer rl.unloadTexture(peon);

    const alfil: rl.Texture = rl.Texture.init("/home/mikel/Escritorio/zchess/src/static/alfil.png");
    defer rl.unloadTexture(alfil);

    const caballo: rl.Texture = rl.Texture.init("/home/mikel/Escritorio/zchess/src/static/caballo.png");
    defer rl.unloadTexture(caballo);

    const torre: rl.Texture = rl.Texture.init("/home/mikel/Escritorio/zchess/src/static/torre.png");
    defer rl.unloadTexture(torre);

    const reina: rl.Texture = rl.Texture.init("/home/mikel/Escritorio/zchess/src/static/reina.png");
    defer rl.unloadTexture(reina);

    const rey: rl.Texture = rl.Texture.init("/home/mikel/Escritorio/zchess/src/static/rey.png");
    defer rl.unloadTexture(rey);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        var cl = rl.Color.white;
        var contrast = rl.Color.gray;

        for (t.piezas, 0..) |c, i| {
            for (c, 0..) |r, j| {
                const x: i32 = @intCast(j);
                const y: i32 = @intCast(i);
                if (i % 2 == 0) {
                    if (j % 2 == 0) {
                        cl = rl.Color.white;
                        contrast = rl.Color.black;
                    } else {
                        cl = rl.Color.dark_gray;
                        contrast = rl.Color.white;
                    }
                } else {
                    if (j % 2 == 0) {
                        cl = rl.Color.dark_gray;
                        contrast = rl.Color.white;
                    } else {
                        cl = rl.Color.white;
                        contrast = rl.Color.black;
                    }
                }
                rl.drawRectangle(x * PIXEL, y * PIXEL, PIXEL, PIXEL, cl);
                if (r == null) {
                    rl.drawText("Vacia", x * PIXEL, y * PIXEL, 12, rl.Color.black);
                } else {
                    switch (r.?.tipo) {
                        pieza.TipoPieza.Peon => rl.drawTexture(peon, x * PIXEL, y * PIXEL, r.?.get_color()),
                        pieza.TipoPieza.Torre => rl.drawTexture(torre, x * PIXEL, y * PIXEL, r.?.get_color()),
                        pieza.TipoPieza.Caballo => rl.drawTexture(caballo, x * PIXEL, y * PIXEL, r.?.get_color()),
                        pieza.TipoPieza.Alfil => rl.drawTexture(alfil, x * PIXEL, y * PIXEL, r.?.get_color()),
                        pieza.TipoPieza.Reina => rl.drawTexture(reina, x * PIXEL, y * PIXEL, r.?.get_color()),
                        pieza.TipoPieza.Rey => rl.drawTexture(rey, x * PIXEL, y * PIXEL, r.?.get_color()),
                    }
                }
            }
        }
        rl.clearBackground(rl.Color.white);
    }
}
