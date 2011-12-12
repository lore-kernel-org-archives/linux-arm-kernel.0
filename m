From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Dec 2011 20:42:42 +0100
Subject: [GIT PULL] ux500 patches for 3.3
Message-ID: <1323718962-4726-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Arnd,

here is a set of three patches for ux500 I have queued for the
3.3 merge window, can you please pull them into arm-soc? I expect
to come up with more patches but depends on what time permits.

The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:

  Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git for-arnd

Linus Walleij (1):
      ARM: ux500: update the MOP500 GPIO assignments

Stefan Nilsson XK (2):
      ARM: ux500: support SD cards on HREFv60 boards
      ARM: ux500: add device sdi1 for SDIO

 arch/arm/mach-ux500/board-mop500-sdi.c |   38 +++++++++++++++++++
 arch/arm/mach-ux500/board-mop500.c     |    2 +-
 arch/arm/mach-ux500/board-mop500.h     |   63 +++++++++++++++++++++++++-------
 3 files changed, 89 insertions(+), 14 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO5lhkAAoJEEEQszewGV1zjQQP+wf3Nvvc8sckc/cXGlzdM6OJ
dWTyQyh1mu3K7m/dh3CIJdxEBWqxF4eFFuqyJ7nM81xw1bn8mQGLOaskZ5ot2OUF
ibdjACTaX97WTftX+sKilUYKQf22sfwtlHtOQsnFSqp3r9zG+F38qwQyL/vjnOKf
w+V1JNYSx1tdo5I/sSy45bilyrGb26Du2OBXdEv8ogRNxRyy+F89iCW0DfZgDumi
BP+oTFwidlPEZv0sRg3hyIBIxOqY006m1C2nXaMdOThO0B7L6+KOyRmXVSbXiUQd
aipsb5EoKZHiMP0/jtKqMto6hbWFmECnJDlNK00qsC1qJG23NfJq0BuRMbEkOiHf
FKOJdP2B3Mgc5uCZkKQJh+k9plc3EHg8Pvzra8ms+WcjBGaUOXkPzosqWrkOCmSf
Wj1GPYjs5hwNX+1o2v/22WIiaahKeCUDAmj+Vq6wDHeUsem/owq9ts22Iqo05Tb3
+xEXHgcm2OODP5+uT19lPQOr+WrwCZS571FP/gthGkACpeRga/auDP8OV8lJa5fe
K1uc550q1wAcgw8WbU+Od5PVWaVMV85poB47BTYkWtPKCkY11uQfWYPvXbOQzhfa
h9BXJySBDqzwEHsUFECeACQvo8cYcQj6hofpE7L89f2u/EQfK0qP1z/mzl00vEeC
O43pv5yJoE2mQiHu7jJH
=0ChU
-----END PGP SIGNATURE-----
