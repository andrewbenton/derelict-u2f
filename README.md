derelict-u2f
============

Dynamic bindings to [libu2f][1] version 1.0.1 for the [D Programming Language][2].  libu2f provides an implementation of the U2F protocol, which can be used with U2F devices, such as the yubikey.

Please see the pages [Building and Linking Derelict][3] and [Using Derelict][4], in the Derelict documentation, for information on how to build derelict-u2f and load at runtime.  A simple sample is provided under the example directory, with basic loading below.

```D
import derelict.u2f;

void main() {
    DerelictU2f.load();

    //now add all of your u2f logic...
}
```

[1]: https://github.com/Yubico/libu2f-server
[2]: https://dlang.org
[3]: http://derelictorg.github.io/compiling.html
[4]: http://derelictorg.github.io/using.html
