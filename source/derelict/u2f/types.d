//          Copyright Author 2017.
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module derelict.u2f.types;

private
{
    import core.stdc.config;
    import core.stdc.stdio;
    import derelict.util.system;

    static if(Derelict_OS_Windows) import derelict.util.wintypes;
    static if(Derelict_OS_Posix) import derelict.util.xtypes;
}

alias void* u2fs_ECDSA_t;
alias void* u2fs_X509_t;
alias void* u2fs_EC_KEY_t;
alias u2fs_ctx u2fs_ctx_t;
alias u2fs_reg_res u2fs_reg_res_t;
alias u2fs_auth_res u2fs_auth_res_t;

enum U2FS_CHALLENGE_RAW_LEN = 32;
enum U2FS_CHALLENGE_B64U_LEN = 43;
enum U2FS_PUBLIC_KEY_LEN = 65;
enum U2FS_COUNTER_LEN = 4;

enum u2fs_initflags
{
    U2FS_DEBUG = 1
}

enum u2fs_rc
{
    U2FS_OK = 0,
    U2FS_MEMORY_ERROR = -1,
    U2FS_JSON_ERROR = -2,
    U2FS_BASE64_ERROR = -3,
    U2FS_CRYPTO_ERROR = -4,
    U2FS_ORIGIN_ERROR = -5,
    U2FS_CHALLENGE_ERROR = -6,
    U2FS_SIGNATURE_ERROR = -7,
    U2FS_FORMAT_ERROR = -8
}

enum base64_decodestep
{
    step_a,
    step_b,
    step_c,
    step_d
}

enum base64_encodestep
{
    step_a,
    step_b,
    step_c
}

struct base64_decodestate
{
    base64_decodestep step;
    char plainchar;
}

struct base64_encodestate
{
    base64_encodestep step;
    char result;
    int stepcount;
}

struct u2fs_reg_res
{
    char *keyHandle;
    char *publicKey;
    u2fs_X509_t *attestation_certificate;

    char *attestation_certificate_PEM;
    u2fs_EC_KEY_t *user_public_key;
}

struct u2fs_auth_res
{
    int verified;
    uint counter;
    ubyte user_presence;
}

struct u2fs_ctx
{
    char[U2FS_CHALLENGE_B64U_LEN + 1]  challenge;
    char *keyHandle;
    u2fs_EC_KEY_t *key;
    char *origin;
    char *appid;
}

struct sha256_state
{
    ulong length;
    uint[8] state;
    uint curlen;
    ubyte[64] buf;
}
