pub fn Vec(comptime T: type) type {
    return struct {
        x: T,
        y: T,

        pub fn init(x: T, y: T) Vec(T) {
            return Vec(T){
                .x = x,
                .y = y,
            };
        }
    };
}
