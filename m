From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 13 Aug 2010 22:59:27 +0800
Subject: [GIT PULL 2] pxa: three ULPI supporting patches
Message-ID: <AANLkTimGnr=sOOqGkwRFdQ3idD29y6HM-Dm3G+0RmCHU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Please help pull the changes below, thanks.

The following changes since commit 5af568cbd55f60b5a1d174f621b273e4f585dc35:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../viro/vfs-2.6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Igor Grinberg (3):
      [ARM] pxa: add U2D controller and ULPI driver for pxa3xx
      ohci-pxa27x: enable OHCI over U2DC for pxa3xx
      [ARM] pxa/cm-x300: enable USB host port2

 arch/arm/mach-pxa/Kconfig                   |    4 +
 arch/arm/mach-pxa/Makefile                  |    2 +-
 arch/arm/mach-pxa/cm-x300.c                 |   77 ++++++
 arch/arm/mach-pxa/devices.c                 |   28 ++
 arch/arm/mach-pxa/devices.h                 |    1 +
 arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h |   35 +++
 arch/arm/mach-pxa/pxa3xx-ulpi.c             |  392 +++++++++++++++++++++++++++
 arch/arm/mach-pxa/pxa3xx.c                  |    2 +-
 drivers/usb/host/ohci-pxa27x.c              |    7 +
 9 files changed, 546 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h
 create mode 100644 arch/arm/mach-pxa/pxa3xx-ulpi.c
