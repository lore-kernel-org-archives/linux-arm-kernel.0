From: olof@lixom.net (Olof Johansson)
Date: Fri, 22 Jan 2016 14:22:25 -0800
Subject: [GIT PULL 1/2] ARM: SoC fixes for v4.5 merge window
Message-ID: <20160122222225.GA14759@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 2cb58c016673c4c8b8ec59e71c5ec4b2c6a76afb:

  ARM: realview: don't select SMP_ON_UP for UP builds (2015-12-31 23:52:20 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git armsoc-fixes

for you to fetch changes up to 53c517a83741718e35dd0494eb271c3c6e3820e5:

  Merge tag 'renesas-fixes-for-v4.5' of git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into fixes (2016-01-22 08:28:23 -0800)

----------------------------------------------------------------
ARM: SoC fixes for v4.5 merge window

A few fixes for fallout that we didn't catch in time in -next, or smaller
warning fixes that have been discovered since.

----------------------------------------------------------------
Arnd Bergmann (2):
      ARM: debug-ll: fix BCM63xx entry for multiplatform
      soc: qcom/spm: shut up uninitialized variable warning

Geert Uytterhoeven (1):
      ARM: dts: armadillo800eva Correct extal1 frequency to 24 MHz

Linus Walleij (1):
      ARM: realview: fix device tree build

Olof Johansson (1):
      Merge tag 'renesas-fixes-for-v4.5' of git://git.kernel.org/.../horms/renesas into fixes

 arch/arm/Kconfig.debug                        | 17 ++++++-----------
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts |  2 +-
 arch/arm/mach-realview/Makefile               |  3 +--
 drivers/soc/qcom/spm.c                        |  2 +-
 4 files changed, 9 insertions(+), 15 deletions(-)
