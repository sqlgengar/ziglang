const std = @import("std");

pub fn main() !void {
    var reverse_index: usize = 0;

    var gpa: std.heap.GeneralPurposeAllocator(.{}) = .{};
    defer _ = gpa.deinit();

    var raw_data = std.ArrayList(u8).init(gpa.allocator());
    defer raw_data.deinit();

    var integer_data = std.ArrayList(u8).init(gpa.allocator());
    defer integer_data.deinit();

    try raw_data.appendSlice("101");
    reverse_index = 2;

    while (reverse_index >= 0) : (reverse_index -= 1) {
        try integer_data.append(raw_data.items[reverse_index]);
        //if (reverse_index == 0) break;
    }

    std.debug.print("integer array is: {s}\n", .{integer_data.items});
}
