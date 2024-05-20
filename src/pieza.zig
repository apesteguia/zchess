const v = @import("vec.zig");

pub const TipoPieza = enum {
    Peon,
    Alfil,
    Caballo,
    Torre,
    Reina,
    Rey,
};

pub const Color = enum {
    Blancas,
    Negras,
};

pub const Pieza = struct {
    tipo: TipoPieza,
    color: Color,
    pos: v.Vec(usize),

    pub fn new(tipo: TipoPieza, color: Color, pos: v.Vec(usize)) Pieza {
        return Pieza{
            .tipo = tipo,
            .color = color,
            .pos = pos,
        };
    }

    const Self = @This();

    pub fn printTipo(s: Self) [:0]const u8 {
        switch (s.tipo) {
            TipoPieza.Peon => {
                return "Peon";
            },
            else => {
                return "Vacia";
            },
        }
    }
};
