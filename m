From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 24 Aug 2016 16:30:05 +0530
Subject: [GIT PULL 2/3] DaVinci dts updates for v4.9
In-Reply-To: <20160824110006.1866-1-nsekhar@ti.com>
References: <20160824110006.1866-1-nsekhar@ti.com>
Message-ID: <20160824110006.1866-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.9/dts

for you to fetch changes up to 9d05b389846312751108b16f3f8fccd51fa92715:

  ARM: dts: da850-lcdk: Audio support via simple-card (2016-08-19 17:51:27 +0530)

----------------------------------------------------------------
DaVinci DA850 device-tree enhancements include:

- Support for new board OMAP-L138 LCDK
- Add AEMIF node on DA850 EVM and use it for NAND
- Audio support for LCDK
- Cleanups for PWM and UART

----------------------------------------------------------------
Cooper Jr., Franklin (1):
      ARM: dts: da850: Add new ECAP and EPWM bindings

Karl Beldan (4):
      ARM: dts: da850: Add missing pin muxing for the UARTs
      ARM: dts: da850: Add basic DTS for the LCDK
      ARM: dts: da850,da850-evm: Add an aemif node and use it for the NAND
      ARM: dts: da850-lcdk: Audio support via simple-card

 Documentation/devicetree/bindings/arm/davinci.txt |   4 +
 arch/arm/boot/dts/Makefile                        |   1 +
 arch/arm/boot/dts/da850-evm.dts                   |  49 +++++++-
 arch/arm/boot/dts/da850-lcdk.dts                  | 138 ++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi                      |  80 ++++++++-----
 arch/arm/mach-davinci/da8xx-dt.c                  |   1 +
 6 files changed, 239 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/boot/dts/da850-lcdk.dts
