import os
import platform
from functools import lru_cache


cdef extern from 'windows.h':
    ctypedef void* HANDLE
    ctypedef int BOOL
    ctypedef unsigned long DWORD

    BOOL CloseHandle(HANDLE hObject)
    HANDLE OpenProcess(DWORD dwDesiredAccess, BOOL bInheritHandle, DWORD dbProcessId)

    cdef extern int PROCESS_QUERY_INFORMATION


@lru_cache(maxsize=None)
def uid2user(uid, default=None):
    print(uid, default)
    return default
    # try:
    #     return pwd.getpwuid(uid).pw_name
    # except KeyError:
    #     return default


@lru_cache(maxsize=None)
def user2uid(user, default=None):
    print(user, default)
    return default
    # try:
    #     return user and pwd.getpwnam(user).pw_uid
    # except KeyError:
    #     return default


@lru_cache(maxsize=None)
def gid2group(gid, default=None):
    print(gid, default)
    return default
    # try:
    #     return grp.getgrgid(gid).gr_name
    # except KeyError:
    #     return default


@lru_cache(maxsize=None)
def group2gid(group, default=None):
    print(group, default)
    return default
    # try:
    #     return group and grp.getgrnam(group).gr_gid
    # except KeyError:
    #     return default


def getosusername():
    """Return the os user name."""
    return os.getlogin()


def process_alive(host, pid, thread):
    """
    Check if the (host, pid, thread_id) combination corresponds to a potentially alive process.
    """
    if host.split('@')[0].lower() != platform.node().lower():
        # Not running on the same node, asume running
        return True

    # If the process can be opened, the process is alive
    handle = OpenProcess(PROCESS_QUERY_INFORMATION, False, pid)
    if handle != NULL:
        CloseHandle(handle)
        return True
    return False


def local_pid_alive(pid):
    """Return whether *pid* is alive."""
    raise NotImplementedError
