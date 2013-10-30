From: bcm@fixthebug.org (Christian Daudt)
Date: Tue, 29 Oct 2013 23:18:37 -0700
Subject: [GIT PULL] bcm soc updates for 3.13
Message-ID: <CAEPRUYrrFiU6KkQ=1byXLXP3CJnUB++afuQfOfj2D+hZaDZTxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
 This git pull request replaces the previous git pull for 3.13/soc. It
contains the mods for the ARCH_BCM_MOBILE patch to align better with
other MULTIPLATFORM usage.

 Thanks,
   csd


The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:

  Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)

are available in the git repository at:

  git://github.com/broadcom/bcm11351.git tags/bcm-for-3.13-soc2

for you to fetch changes up to 2d58b26550ad5d869118c77b3db8feb942e54be0:

  ARM: bcm_defconfig: Run "make savedefconfig" (2013-10-29 23:09:10 -0700)

----------------------------------------------------------------
BCM changes for 3.13/soc. A number of cleanup related changes.

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
 arch/arm/mach-bcm/Kconfig           | 22 +++++++++++++++++++---
 arch/arm/mach-bcm/Makefile          |  2 +-
 arch/arm/mach-bcm/board_bcm281xx.c  |  2 +-
 5 files changed, 24 insertions(+), 12 deletions(-)
