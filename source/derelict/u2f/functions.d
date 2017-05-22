module derelict.u2f.functions;

private
{
    import core.stdc.stdarg;
    import derelict.util.system;
    import derelict.u2f.types;
}

extern(C) @nogc nothrow
{
    alias da_u2fs_check_version = const(char) *function(const(char) *req_version);

    alias da_u2fs_global_init = u2fs_rc function(u2fs_initflags flags);
    alias da_u2fs_global_done = void function();

    alias da_u2fs_strerror = const(char) *function(int err);
    alias da_u2fs_strerror_name = const(char) *function(int err);

    alias da_u2fs_init = u2fs_rc function(u2fs_ctx_t **ctx);
    alias da_u2fs_done = void function(u2fs_ctx_t *ctx);
    alias da_u2fs_set_origin = u2fs_rc function(u2fs_ctx_t *ctx, const(char) *origin);
    alias da_u2fs_set_appid = u2fs_rc function(u2fs_ctx_t *ctx, const(char) *appid);
    alias da_u2fs_set_challenge = u2fs_rc function(u2fs_ctx_t *ctx, const(char) *challenge);
    alias da_u2fs_set_keyHandle = u2fs_rc function(u2fs_ctx_t *ctx, const(char) *keyHandle);
    alias da_u2fs_set_publicKey = u2fs_rc function(u2fs_ctx_t *ctx, const(ubyte) *publicKey);

    alias da_u2fs_registration_challenge = u2fs_rc function(u2fs_ctx_t *ctx, char **output);
    alias da_u2fs_registration_verify = u2fs_rc function(u2fs_ctx_t *ctx, const(char) *response, u2fs_reg_res_t **output);

    alias da_u2fs_get_registration_keyHandle = const(char) *function(u2fs_reg_res_t *result);
    alias da_u2fs_get_registration_publicKey = const(char) *function(u2fs_reg_res_t *result);

    alias da_u2fs_authentication_challenge = u2fs_rc function(u2fs_ctx_t *ctx, char **output);
    alias da_u2fs_authentication_verify = u2fs_rc function(u2fs_ctx_t *ctx, const(char) *response, u2fs_auth_res_t **output);

    alias da_u2fs_get_authentication_result = u2fs_rc function(u2fs_auth_res_t *result, u2fs_rc *verified, uint *counter, ubyte *user_presence);
    alias da_u2fs_free_auth_res = void function(u2fs_auth_res_t *result);
}

__gshared
{
    da_u2fs_check_version u2fs_check_version;

    da_u2fs_global_init u2fs_global_init;
    da_u2fs_global_done u2fs_global_done;

    da_u2fs_strerror u2fs_strerror;
    da_u2fs_strerror_name u2fs_strerror_name;

    da_u2fs_init u2fs_init;
    da_u2fs_done u2fs_done;
    da_u2fs_set_origin u2fs_set_origin;
    da_u2fs_set_appid u2fs_set_appid;
    da_u2fs_set_challenge u2fs_set_challenge;
    da_u2fs_set_keyHandle u2fs_set_keyHandle;
    da_u2fs_set_publicKey u2fs_set_publicKey;

    da_u2fs_registration_challenge u2fs_registration_challenge;
    da_u2fs_registration_verify u2fs_registration_verify;

    da_u2fs_get_registration_keyHandle u2fs_get_registration_keyHandle;
    da_u2fs_get_registration_publicKey u2fs_get_registration_publicKey;

    da_u2fs_authentication_challenge u2fs_authentication_challenge;
    da_u2fs_authentication_verify u2fs_authentication_verify;

    da_u2fs_get_authentication_result u2fs_get_authentication_result;
    da_u2fs_free_auth_res u2fs_free_auth_res;
}
