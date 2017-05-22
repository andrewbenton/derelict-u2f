import derelict.u2f.u2f;
import derelict.u2f.types;
import derelict.u2f.functions;

import core.stdc.stdlib;

import std.exception;

void ck_assert(T)(T a, T b)
{
    import std.conv : to;
    enforce(a == b, a.to!string);
}

void ck_assert_str(char *a, char *b)
{
    import std.string : fromStringz;
    enforce(a.fromStringz == b.fromStringz);
}

void ck_assert_neq(char *a, char *b)
{
    import std.string : fromStringz;
    enforce(a.fromStringz != b.fromStringz);
}

void main()
{
    import std.algorithm.comparison : equal;
    import std.string : fromStringz;

    DerelictU2f.load;

    u2fs_ctx_t *ctx;

    ck_assert(u2fs_global_init(u2fs_initflags.U2FS_DEBUG), u2fs_rc.U2FS_OK);
    ck_assert(u2fs_init(&ctx), u2fs_rc.U2FS_OK);

    ck_assert(u2fs_set_challenge(ctx, ""), u2fs_rc.U2FS_CHALLENGE_ERROR);
    ck_assert(u2fs_set_challenge(ctx, null), u2fs_rc.U2FS_MEMORY_ERROR);
    ck_assert(u2fs_set_challenge
            (ctx, "dDwRsjdFoPHZ5Qg2fHQsFba0NKl-F1hxjJ3uLLk5gbA\0"),
            u2fs_rc.U2FS_OK);

    //need to compare the ptr.fromStringz with the d string
    enforce(equal(ctx.challenge.ptr.fromStringz, "dDwRsjdFoPHZ5Qg2fHQsFba0NKl-F1hxjJ3uLLk5gbA"), ctx.challenge);

    //length converted to length-1 for c/d string
    enforce(ctx.challenge.length-1 == U2FS_CHALLENGE_B64U_LEN);

    auto s = ctx.challenge.dup;
    u2fs_done(ctx);
    ck_assert(u2fs_init(&ctx), u2fs_rc.U2FS_OK);

    //length converted to length-1 for c/d string
    ck_assert(ctx.challenge.length-1, U2FS_CHALLENGE_B64U_LEN);

    enforce(ctx.challenge != s);

    u2fs_done(ctx);
    u2fs_global_done();
}
