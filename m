From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 8 Jun 2017 16:53:49 +0530
Subject: [GIT PULL 2/3] DaVinci device-tree updates for v4.13
In-Reply-To: <20170608112350.1602-1-nsekhar@ti.com>
References: <20170608112350.1602-1-nsekhar@ti.com>
Message-ID: <20170608112350.1602-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.13/dt

for you to fetch changes up to 65878b126c8f2d761273241cf778b1c6aa50c500:

  ARM: dts: da850-evm: fix tca6416 for use with GPIO hogs (2017-06-06 15:51:02 +0530)

----------------------------------------------------------------
Miscellaneous DT support updates for DA850. Includes Lego mindstorms
EV3 battery support, DMA support for MUSB, and non-critical fixes to
GPIO nodes of DA850's GPIO controller and GPIO expander available on
DA850 EVM.

----------------------------------------------------------------
Alexandre Bailon (1):
      ARM: dts: da850: Add CPPI 4.1 DMA to USB OTG controller

David Lechner (1):
      ARM: dts: da850-lego-ev3: Add node for LEGO MINDSTORMS EV3 Battery

Keerthy (1):
      ARM: dts: da850: Add interrupt-controller property to gpio node

Kevin Hilman (1):
      ARM: dts: da850-evm: fix tca6416 for use with GPIO hogs

 arch/arm/boot/dts/da850-evm.dts      |  2 ++
 arch/arm/boot/dts/da850-lego-ev3.dts | 28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi         | 29 ++++++++++++++++++++++++++++-
 3 files changed, 58 insertions(+), 1 deletion(-)
