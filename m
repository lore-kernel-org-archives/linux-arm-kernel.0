From: b38611@freescale.com (Fugang Duan)
Date: Tue, 23 Sep 2014 17:36:17 +0800
Subject: [PATCH v1 0/3] ARM: imx6sx: add enet support
Message-ID: <1411464980-2495-1-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The three patches just to enable enet1 and enet2 for imx6sx boards.


Fugang Duan (3):
  ARM: imx6sx: add imx6sx iomux-gpr field define
  ARM: imx: add enet init for i.mx6sx
  ARM: dts: imx6x: Add enet2 support for imx6sx-sdb board

 arch/arm/boot/dts/imx6sx-sdb.dts            |   28 +++++++++++++++
 arch/arm/boot/dts/imx6sx.dtsi               |    2 +-
 arch/arm/mach-imx/mach-imx6sx.c             |   51 +++++++++++++++++++++++++++
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |   39 ++++++++++++++++++++
 4 files changed, 119 insertions(+), 1 deletions(-)

-- 
1.7.8
