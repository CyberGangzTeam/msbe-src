import fnmatch
import platform
import os

if platform.system() == "Darwin":
    if fnmatch.fnmatch(platform.machine(), "iP*"):
        print("ios")
    else:
        print("macos")
elif platform.system() == "Linux":
    if os.path.exists('/system/build.prop'):
        print("android")
    else:
        print("linux")
elif platform.system() == "Windows":
    print("windows")
else:
    print("other")
