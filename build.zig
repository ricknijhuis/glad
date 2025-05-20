const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib_mod = b.createModule(.{
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    lib_mod.addSystemIncludePath(b.path("include"));
    // lib_mod.addIncludePath(b.path("include/glad"));
    // lib_mod.addIncludePath(b.path("include/KHR"));
    lib_mod.addCSourceFile(.{
        .file = b.path("src/gl.c"),
    });

    const lib = b.addLibrary(.{
        .linkage = .static,
        .name = "glad",
        .root_module = lib_mod,
    });

    lib.installHeadersDirectory(b.path("include/glad"), "glad", .{});
    lib.installHeadersDirectory(b.path("include/KHR"), "KHR", .{});

    b.installArtifact(lib);
}
