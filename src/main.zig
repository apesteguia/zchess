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

    const peon_blanco: rl.Texture = rl.Texture.init("/home/mikel/Escritorio/zchess/src/static/peon_blanco.png");
    defer rl.unloadTexture(peon_blanco);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        var cl = rl.Color.white;
        var contrast = rl.Color.black;

        for (t.piezas, 0..) |c, i| {
            for (c, 0..) |r, j| {
                const x: i32 = @intCast(j);
                const y: i32 = @intCast(i);
                if (i % 2 == 0) {
                    if (j % 2 == 0) {
                        cl = rl.Color.white;
                        contrast = rl.Color.black;
                    } else {
                        cl = rl.Color.black;
                        contrast = rl.Color.white;
                    }
                } else {
                    if (j % 2 == 0) {
                        cl = rl.Color.black;
                        contrast = rl.Color.white;
                    } else {
                        cl = rl.Color.white;
                        contrast = rl.Color.black;
                    }
                }
                rl.drawRectangle(x * PIXEL, y * PIXEL, PIXEL, PIXEL, cl);
                if (r == null) {
                    rl.drawText("Vacia", x * PIXEL, y * PIXEL, 12, rl.Color.blue);
                } else {
                    if (r.?.tipo == pieza.TipoPieza.Peon) {
                        rl.drawTexture(peon_blanco, x * PIXEL, y * PIXEL, rl.Color.white);
                    } else {
                        rl.drawText(r.?.printTipo(), x * PIXEL, y * PIXEL, 12, rl.Color.blue);
                    }
                }
            }
        }
        rl.clearBackground(rl.Color.white);
    }
}
