From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 15 Apr 2016 17:44:46 +0530
Subject: [GIT PULL 1/3] DaVinci cleanups for v4.7
Message-ID: <1460722488-5921-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.7/cleanup

for you to fetch changes up to 9a7f2fc8408fdc0e3b417f670c17ed70d5d1c114:

  ARM: davinci: use IRQCHIP_DECLARE for cp_intc (2016-04-14 12:09:50 +0530)

----------------------------------------------------------------
DaVinci cleanups for v4.7. It includes
removal of some unused macros and data-
-structures and use of helper macros to
reduce code.

----------------------------------------------------------------
David Lechner (3):
      ARM: davinci: simplify call to of populate
      ARM: davinci: remove unused DA8XX_NUM_UARTS
      ARM: davinci: use IRQCHIP_DECLARE for cp_intc

Petr Kulhavy (1):
      ARM: DaVinci USB: removed deprecated properties from MUSB config

 arch/arm/mach-davinci/cp_intc.c  |  3 +++
 arch/arm/mach-davinci/da8xx-dt.c | 17 +----------------
 arch/arm/mach-davinci/usb.c      | 16 ----------------
 3 files changed, 4 insertions(+), 32 deletions(-)
