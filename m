From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 Jul 2015 14:14:03 +0200
Subject: [GIT PULL] EP93xx defconfig changes
Message-ID: <CACRpkdaXEMt6qyuZP4cH2OLqK7PhwCcVSk=Xgf5Lfsd1bPSzag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC people,

here is a separate pull request updating the EP93xx
defconfig, partly relying on the changes in the previous
pull request to be meaningful (like NO_HZ) but still
harmless if applied in isolation.

All patches (as well as in the previous pull request) are
ACKed by Hartley.

Pleas pull this in too!

Yours,
Linus Walleij

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/ep93xx-defconfig

for you to fetch changes up to b471e7f2ec5a8673e1b5385307357f3dba62f451:

  ARM: ep93xx: add framebuffer to the defconfig (2015-07-17 11:52:38 +0200)

----------------------------------------------------------------
This updates the EP93xx defconfig to use NO_HZ and high
resolution timers, and to by default enable and compile
all board variants now that we can have a single kernel,
and enable all EP93xx-specific drivers that sit in various
sites across the kernel.

----------------------------------------------------------------
Linus Walleij (7):
      ARM: ep93xx: activate NO_HZ and high-res timers
      ARM: ep93xx: enable all boards in the EP93xx defconfig
      ARM: ep93xx: enable SIM.ONE MMC/SD hardware
      ARM: ep93xx: add LEDs and triggers to defconfig
      ARM: ep93xx: add GPIO I2C to defconfig
      ARM: ep93xx: add DMA engine to the defconfig
      ARM: ep93xx: add framebuffer to the defconfig

 arch/arm/configs/ep93xx_defconfig | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)
