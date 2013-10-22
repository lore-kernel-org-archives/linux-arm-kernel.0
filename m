From: bcm@fixthebug.org (Christian Daudt)
Date: Mon, 21 Oct 2013 22:35:38 -0700
Subject: [GIT PULL] bcm soc updates for 3.13
Message-ID: <CAEPRUYrQ94u4NzbFBOY2E5_B3aoiNLKDcbehsU+J-pVMT64YWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:

  Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)

are available in the git repository at:

  git://github.com/broadcom/bcm11351.git tags/bcm-for-3.13-soc

for you to fetch changes up to 501b022a394992f8b673e74900976adb44b7f36d:

  ARM: bcm_defconfig: Run "make savedefconfig" (2013-10-16 22:44:26 -0700)

----------------------------------------------------------------
BCM changes for 3.13/soc. A number of cleanup related changed.

----------------------------------------------------------------
Christian Daudt (3):
      ARM: bcm281xx: more descriptive machine string
      rename ARCH_BCM to ARCH_BCM_MOBILE (mach-bcm)
      ARM: bcm281xx: Add ARCH Timers to config

Markus Mayer (1):
      ARM: bcm281xx: Enable GPIO driver

Tim Kryger (1):
      ARM: bcm_defconfig: Run "make savedefconfig"

 arch/arm/configs/bcm_defconfig      |  9 ++-------
 arch/arm/configs/multi_v7_defconfig |  1 +
 arch/arm/mach-bcm/Kconfig           | 23 ++++++++++++++++++++---
 arch/arm/mach-bcm/Makefile          |  2 +-
 arch/arm/mach-bcm/board_bcm281xx.c  |  2 +-
 5 files changed, 25 insertions(+), 12 deletions(-)
