From: B38611@freescale.com (Fugang Duan)
Date: Tue, 3 Sep 2013 12:26:21 +0800
Subject: [PATCH v2 0/4] *** ARM: imx6sl: add FEC support for imx6sl evk
 platform ***
Message-ID: <1378182385-9205-1-git-send-email-B38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:

V2:
 * Split iomuxc-gpr and fec phy gpio reset dts patch
 * Sort included header file

v1:
 * Add iomuxc-gpr device node
 * Add imx6sl evk fec phy gpio reset
 * Add imx6sl iomuxc-gpr fec gpr field define
 * Add fec init function to select clock source.

Fugang Duan (4):
  ARM: dts: add iomuxc-gpr device node for imx6sl
  ARM: dts: add fec phy reset for imx6sl evk board
  ARM: imx6sl: add imx6sl iomux-gpr field define
  ARM: imx6sl: config iomux-gpr1 to select clock for fec

 arch/arm/boot/dts/imx6sl-evk.dts            |    3 +++
 arch/arm/boot/dts/imx6sl.dtsi               |    5 +++++
 arch/arm/mach-imx/mach-imx6sl.c             |   21 +++++++++++++++++++++
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |    5 +++++
 4 files changed, 34 insertions(+), 0 deletions(-)
