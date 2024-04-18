const std = @import("std");

pub fn main() !void {
    // Variables generales.
    var decimal_number: f64 = 0;
    var integer_number: usize = 0;
    var reverse_index: usize = 0;
    var index: usize = 0;
    var length: usize = 0;
    var is_float: bool = false;
    const delimiter_decimal: u8 = ',';
    var index_delimiter_decimal: usize = 0;
    const max_line_length = 10_000;
    const in = std.io.getStdIn().reader();

    // Entrada de datos.
    std.debug.print("Enter the binari number to convert:\n", .{});

    var gpa: std.heap.GeneralPurposeAllocator(.{}) = .{};
    defer _ = gpa.deinit();

    var raw_data = std.ArrayList(u8).init(gpa.allocator());
    defer raw_data.deinit();

    var integer_data = std.ArrayList(u8).init(gpa.allocator());
    defer integer_data.deinit();

    var decimal_data = std.ArrayList(u8).init(gpa.allocator());
    defer decimal_data.deinit();

    try in.streamUntilDelimiter(raw_data.writer(), '\n', max_line_length);

    // Obtener si el numero el decimal y la posicion del delimiter.
    for (raw_data.items) |bit| {
        if (bit == delimiter_decimal) {
            is_float = true;
            break;
        }

        index_delimiter_decimal += 1;
    }

    reverse_index = index_delimiter_decimal - 1;
    index = index_delimiter_decimal + 1;
    length = raw_data.items.len;

    // Crear arrary inverso de solo numeros entero y array de decimales.
    while (reverse_index >= 0) : (reverse_index -= 1) {
        try integer_data.append(raw_data.items[reverse_index]);
        if (reverse_index == 0) break;
    }

    while (index < length) : (index += 1) {
        try decimal_data.append(raw_data.items[index]);
    }

    // Calcular conversion de numero.
    index = 0;
    while (index < length) : (index += 1) {
        integer_number += std.math.pow(usize, integer_data.items[index], index);
    }

    index = 0;
    while (index < length) : (index += 1) {
        var denominator = std.math.pow(usize, decimal_data.items[index], index);
        decimal_number += (1.0 / (@as(f64, denominator)));
    }

    //index = 0;
    //while (index < length) : (index += 1) {
    //    pow = @as(isize, @bitCast(index)) * -1;
    //    decimal_number += std.math.pow(isize, @as(isize, @bitCast(integer_number)), pow);
    //}

    std.debug.print("integer is: {any}\n", .{integer_number});
    std.debug.print("decimal is: {any}\n", .{decimal_number});
}
