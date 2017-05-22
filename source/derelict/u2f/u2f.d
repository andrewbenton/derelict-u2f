//          Copyright Author 2017.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module derelict.u2f.u2f;

public
{
    import derelict.u2f.functions;
    import derelict.u2f.types;
    import derelict.util.loader;
}

private
{
    import derelict.util.exception,
           derelict.util.system;

    static if(Derelict_OS_Windows)
        enum libNames = "u2f.dll";
    else static if(Derelict_OS_Mac)
        enum libNames = "/usr/local/lib/libu2f-server.dylib";
    else static if(Derelict_OS_Posix)
        enum libNames = "/usr/lib64/libu2f-server.so, /usr/lib64/libu2f-server.so.0, /usr/lib64/libu2f-server.so.0.0.3, libu2f-server.so libu2f-server.so.0 libu2f-server.so.0.0.3";
    else
        static assert(0, "Need to implement u2f-server libNames for this operating system");
}

class DerelictU2fLoader : SharedLibLoader
{
    public this()
    {
        super(libNames);
    }

    protected override void configureMinimumVersion(SharedLibVersion minVersion)
    {
        this.missingSymbolCallback = &symbolCallback;
    }

    protected override void loadSymbols()
    {
        bindFunc(cast(void**)&u2fs_check_version, "u2fs_check_version");

        bindFunc(cast(void**)&u2fs_global_init, "u2fs_global_init");
        bindFunc(cast(void**)&u2fs_global_done, "u2fs_global_done");

        bindFunc(cast(void**)&u2fs_strerror, "u2fs_strerror");
        bindFunc(cast(void**)&u2fs_strerror_name, "u2fs_strerror_name");

        bindFunc(cast(void**)&u2fs_init, "u2fs_init");
        bindFunc(cast(void**)&u2fs_done, "u2fs_done");
        bindFunc(cast(void**)&u2fs_set_origin, "u2fs_set_origin");
        bindFunc(cast(void**)&u2fs_set_appid, "u2fs_set_appid");
        bindFunc(cast(void**)&u2fs_set_challenge, "u2fs_set_challenge");
        bindFunc(cast(void**)&u2fs_set_keyHandle, "u2fs_set_keyHandle");
        bindFunc(cast(void**)&u2fs_set_publicKey, "u2fs_set_publicKey");

        bindFunc(cast(void**)&u2fs_registration_challenge, "u2fs_registration_challenge");
        bindFunc(cast(void**)&u2fs_registration_verify, "u2fs_registration_verify");

        bindFunc(cast(void**)&u2fs_get_registration_keyHandle, "u2fs_get_registration_keyHandle");
        bindFunc(cast(void**)&u2fs_get_registration_publicKey, "u2fs_get_registration_publicKey");

        bindFunc(cast(void**)&u2fs_authentication_challenge, "u2fs_authentication_challenge");
        bindFunc(cast(void**)&u2fs_authentication_verify, "u2fs_authentication_verify");

        bindFunc(cast(void**)&u2fs_get_authentication_result, "u2fs_get_authentication_result");
        bindFunc(cast(void**)&u2fs_free_auth_res, "u2fs_free_auth_res");
    }

    private ShouldThrow symbolCallback(string symbolName)
    {
        import std.stdio : writefln;

        writefln("Missing u2f symbol: %s", symbolName);

        return ShouldThrow.No;
    }
}

__gshared DerelictU2fLoader DerelictU2f;

shared static this()
{
    DerelictU2f = new DerelictU2fLoader();
}

unittest
{
    import std.string;
    import std.stdio;

    DerelictU2f.load;
    DerelictU2f.writeln;

    auto val = u2fs_global_init(cast(u2fs_initflags)1);

    u2fs_check_version(null).fromStringz.writeln;
}
