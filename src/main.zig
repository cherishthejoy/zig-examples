const std = @import("std");
const expect = @import("std").testing.expect;

const name = "Constant";

const constant: i32 = 5;
var variable: u32 = 5000;

const a = [5]u8{ 'h', 'e', 'l', 'l', 'o' };
const b = [_]u8{ 'w', 'o', 'r', 'l', 'd' };

// If statement
test "if statement" {
    const c = true;
    var x: u16 = 0;
    if (c) {
        x += 1;
    } else {
        x += 2;
    }
    try expect(x == 1);
}

// Alternative
test "if statement expression" {
    const c = true;
    var x: u16 = 0;
    x += if (c) 1 else 2;
    try expect(x == 1);
}

// While-loop
test "while" {
    var i: u8 = 2;
    while (i < 100) {
        i *= 2;
    }
    try expect(i == 128);
}

// While-loop with continue expression
// (i += 1) executes after expression or at the end of the block
test "while with continue expression" {
    var sum: u8 = 0;
    var i: u8 = 1;
    while (i <= 10) : (i += 1) {
        sum += i;
    }
    try expect(sum == 55);
}

// While-loop with continue
// If condition is met, skip the current iteration right away
test "while with continue" {
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i <= 3) : (i += 1) {
        if (i == 2) continue;
        sum += i;
    }
    try expect(sum == 4);
}

// For-loop
test "for" {
    // Character literals are equivalent to integer liters
    const string = [_]u8{ 'a', 'b', 'c' };

    for (string, 0..) |character, index| {
        _ = character;
        _ = index;
    }

    for (string) |character| {
        _ = character;
    }

    for (string, 0..) |_, index| {
        _ = index;
    }

    for (string) |_| {}
}

// Bit of casting
fn addFive(x: u32) u16 {
    const i: u32 = x + 5;
    return @intCast(i);
}

test "function" {
    // @TypeOf(var | const) to check their type
    const y = addFive(0);
    try expect(@TypeOf(y) == u16);
    try expect(y == 5);
}

test "defer" {
    var x: i16 = 5;
    {
        defer x += 2;
        try expect(x == 5);
    }
    try expect(x == 7);
}

pub fn main() void {
    std.debug.print("Hello, {s}!\n", .{"World"});
    std.debug.print("{s} : {d}\nVariable : {d}\n", .{ name, constant, variable });
    std.debug.print("List A : {c} Length : {d}\n", .{ a, a.len });
    std.debug.print("List B : {c} Length : {d}\n", .{ b, b.len });

    const string = "Hello";
    for (string, 0..) |character, index| {
        std.debug.print("Character: {c}, Index: {d}\n", .{ character, index });
    }

    for (string, 0..) |_, index| {
        std.debug.print("Index: {d}\n", .{index});
    }
}
