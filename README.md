# python-build

Build Python 3 from source on Ubuntu with profile-guided and link-time
optimizations.

Run the script as your regular user:

```bash
bash build_python.sh
```

Enter a stable Python 3 version in `3.minor.patch` format, or press Enter to use
the default, `3.15.2`. The script validates the version before installing
dependencies. It uses `sudo` to install build dependencies and the finished
Python, without performing a system-wide package upgrade.

Sources are built in a temporary directory that is removed when the script
exits, including after a build failure. Compilation uses the available CPU cores.

Installation uses `make altinstall`, preserving the versions of Python provided
by the system. The default executable is `/usr/local/bin/python3.15`; other
versions use `/usr/local/bin/python<major>.<minor>`.

# License

This script is MIT-licensed. Feel free to use it and contribute.
