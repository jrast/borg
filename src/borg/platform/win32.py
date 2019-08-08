import os
from functools import lru_cache

import platform


@lru_cache(maxsize=None)
def uid2user(uid, default=None):
    print(uid, default)
    try:
        return pwd.getpwuid(uid).pw_name
    except KeyError:
        return default


@lru_cache(maxsize=None)
def user2uid(user, default=None):
    print(user, default)
    try:
        return user and pwd.getpwnam(user).pw_uid
    except KeyError:
        return default


@lru_cache(maxsize=None)
def gid2group(gid, default=None):
    print(gid, default)
    try:
        return grp.getgrgid(gid).gr_name
    except KeyError:
        return default


@lru_cache(maxsize=None)
def group2gid(group, default=None):
    print(group, default)
    try:
        return group and grp.getgrnam(group).gr_gid
    except KeyError:
        return default


def getosusername():
    """Return the os user name."""
    return os.getlogin()


def process_alive(host, pid, thread):
    """
    Check if the (host, pid, thread_id) combination corresponds to a potentially alive process.
    """
    if host.split('@')[0].lower() != platform.node().lower():
        return True
    import psutil
    return psutil.pid_exists(pid)


def local_pid_alive(pid):
    """Return whether *pid* is alive."""
    raise NotImplementedError
