From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 29 Apr 2016 17:37:05 +0530
Subject: [GIT PULL 2/4] DaVinci DT updates for v4.7 (part 2)
In-Reply-To: <1461931627-27761-1-git-send-email-nsekhar@ti.com>
References: <1461931627-27761-1-git-send-email-nsekhar@ti.com>
Message-ID: <1461931627-27761-2-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6c8f73592203b8611c6ba5d4c670c82a059ecf27:

  ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for i2c1 (2016-04-14 11:41:04 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.7/dt-part2

for you to fetch changes up to c6d3b5dd8e6fd802a354590314df28d6024906d8:

  ARM: dts: da850: There are 101 interrupts. (2016-04-25 18:59:16 +0530)

----------------------------------------------------------------
Second set of DT updates for DaVinci
adding support for SPI0 and some low
priority fixes for ethernet and interrupt
controller.

----------------------------------------------------------------
David Lechner (4):
      ARM: dts: da850: add spi0 to device tree
      ARM: davinci: da8xx-dt: Add spi0 lookup for clock matching
      ARM: dts: da850: disable mdio and eth0 in da850.dtsi
      ARM: dts: da850: There are 101 interrupts.

 arch/arm/boot/dts/da850-enbw-cmc.dts |  6 ++++++
 arch/arm/boot/dts/da850.dtsi         | 28 ++++++++++++++++++++++++++--
 arch/arm/mach-davinci/da8xx-dt.c     |  1 +
 3 files changed, 33 insertions(+), 2 deletions(-)
