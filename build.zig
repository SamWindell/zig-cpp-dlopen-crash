const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe_is_cpp = b.option(bool, "exe_is_cpp", "Compile the program that calls dlopen() as C++") orelse true;

    const exe = b.addExecutable(.{
        .name = "exe",
        .target = target,
        .optimize = optimize,
    });
    exe.addCSourceFile(.{
        .file = .{ .path = if (exe_is_cpp) "src/exe_main.cpp" else "src/exe_main.c" },
        .flags = &.{},
    });
    exe.linkLibC();
    if (exe_is_cpp) exe.linkLibCpp();
    b.installArtifact(exe);

    const lib = b.addSharedLibrary(.{ .name = "lib", .target = target, .optimize = optimize });
    lib.addCSourceFile(.{
        .file = .{ .path = "src/lib.cpp" },
        .flags = &.{},
    });
    lib.linkLibC();
    lib.linkLibCpp();
    b.installArtifact(lib);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    run_cmd.addFileArg(lib.getEmittedBin());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
