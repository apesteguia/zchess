const std = @import("std");
const p = @import("pieza.zig");
const v = @import("vec.zig");

pub const N = 8;

pub const Tablero = struct {
    piezas: [N][N]?p.Pieza,
    turno: p.Color,
    ganador: ?p.Color,
    valor_blancas: i32,
    valor_negras: i32,

    pub fn new() Tablero {
        var piezas: [N][N]?p.Pieza = undefined;
        for (piezas, 0..) |c, i| {
            for (c, 0..) |_, j| {
                //std.debug.print("{}{} ", .{ i, j });
                if ((i == 1) or (i == 6)) {
                    piezas[i][j] = p.Pieza.new(p.TipoPieza.Peon, p.Color.Blancas, v.Vec(usize).init(i, j));
                } else {
                    piezas[i][j] = null;
                }
            }
            //std.debug.print("\n", .{});
        }

        return Tablero{
            .piezas = piezas,
            .turno = p.Color.Blancas,
            .ganador = null,
            .valor_blancas = 0,
            .valor_negras = 0,
        };
    }
};
