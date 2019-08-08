Borg Native on Windows
======================

Build Requirements
------------------

- VC 14.0 Compiler
- OpenSSL Library (https://slproweb.com/products/Win32OpenSSL.html)
- Patience and a lot of coffee / beer

What's working
--------------

.. note::
   The following examples assume that the `BORG_REPO` and `BORG_PASSPHRASE` environment variables are set
   if the repo or passphrase is not explicitly given.

- Borg does not crash if called with ``borg``
- ``borg init --encryption repokey-blake2 ./demoRepo`` runs without an error/warning.
  Note that absolute paths only work if the protocol is explicitly set to file://
- ``borg create ::backup-{now} D:\DemoData`` works as expected.
- ``borg list`` works as expected.
- ``borg extract --strip-components 1 ::backup-XXXX`` works. It's important to
  pass ``--strip-components 1`` as otherwise the data is restored to the
  original location.
