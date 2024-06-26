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

    const Self = @This();

    pub fn movimientos_posibles(self: *Self, allocator: std.mem.Allocator, pos: v.Vec(usize)) ![]v.Vec(usize) {
        var array = std.ArrayList(v.Vec(usize)).init(allocator);
        defer array.deinit();

        const current = self.piezas[pos.x][pos.y];
        std.debug.print("{}", .{current.?.tipo});

        if (current) |pieza| {
            switch (pieza.tipo) {
                p.TipoPieza.Peon => {
                    return try self.movimiento_peon(&array, pos);
                },
                else => {},
            }
        }

        return array.toOwnedSlice();
    }

    fn movimiento_peon(self: *Self, array: *std.ArrayList(v.Vec(usize)), pos: v.Vec(usize)) ![]v.Vec(usize) {
        if (self.turno == p.Color.Blancas) {
            std.debug.print("", .{});
        }
        const forward = v.Vec(usize){ .x = pos.x, .y = pos.y + 1 };
        try array.append(forward);

        return array.toOwnedSlice();
    }

    pub fn new() Tablero {
        var piezas: [N][N]?p.Pieza = undefined;
        for (piezas, 0..) |c, i| {
            for (c, 0..) |_, j| {
                if ((i == 1) or (i == 6)) {
                    if (i == 1) {
                        piezas[i][j] = p.Pieza.new(p.TipoPieza.Peon, p.Color.Negras, v.Vec(usize).init(i, j));
                    } else {
                        piezas[i][j] = p.Pieza.new(p.TipoPieza.Peon, p.Color.Blancas, v.Vec(usize).init(i, j));
                    }
                } else {
                    piezas[i][j] = null;
                }
            }
        }

        piezas[0][0] = p.Pieza.new(p.TipoPieza.Torre, p.Color.Negras, v.Vec(usize).init(0, 0));
        piezas[0][1] = p.Pieza.new(p.TipoPieza.Caballo, p.Color.Negras, v.Vec(usize).init(0, 1));
        piezas[0][2] = p.Pieza.new(p.TipoPieza.Alfil, p.Color.Negras, v.Vec(usize).init(0, 2));
        piezas[0][3] = p.Pieza.new(p.TipoPieza.Reina, p.Color.Negras, v.Vec(usize).init(0, 3));
        piezas[0][4] = p.Pieza.new(p.TipoPieza.Rey, p.Color.Negras, v.Vec(usize).init(0, 4));
        piezas[0][5] = p.Pieza.new(p.TipoPieza.Alfil, p.Color.Negras, v.Vec(usize).init(0, 5));
        piezas[0][6] = p.Pieza.new(p.TipoPieza.Caballo, p.Color.Negras, v.Vec(usize).init(0, 6));
        piezas[0][7] = p.Pieza.new(p.TipoPieza.Torre, p.Color.Negras, v.Vec(usize).init(0, 7));

        piezas[7][0] = p.Pieza.new(p.TipoPieza.Torre, p.Color.Blancas, v.Vec(usize).init(0, 0));
        piezas[7][1] = p.Pieza.new(p.TipoPieza.Caballo, p.Color.Blancas, v.Vec(usize).init(0, 1));
        piezas[7][2] = p.Pieza.new(p.TipoPieza.Alfil, p.Color.Blancas, v.Vec(usize).init(0, 2));
        piezas[7][3] = p.Pieza.new(p.TipoPieza.Reina, p.Color.Blancas, v.Vec(usize).init(0, 3));
        piezas[7][4] = p.Pieza.new(p.TipoPieza.Rey, p.Color.Blancas, v.Vec(usize).init(0, 4));
        piezas[7][5] = p.Pieza.new(p.TipoPieza.Alfil, p.Color.Blancas, v.Vec(usize).init(0, 5));
        piezas[7][6] = p.Pieza.new(p.TipoPieza.Caballo, p.Color.Blancas, v.Vec(usize).init(0, 6));
        piezas[7][7] = p.Pieza.new(p.TipoPieza.Torre, p.Color.Blancas, v.Vec(usize).init(0, 7));

        return Tablero{
            .piezas = piezas,
            .turno = p.Color.Blancas,
            .ganador = null,
            .valor_blancas = 0,
            .valor_negras = 0,
        };
    }
};
