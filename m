From: b32955@freescale.com (Huang Shijie)
Date: Thu, 9 May 2013 11:29:01 +0800
Subject: [PATCH 3/5] ARM: dts: imx6dl: add a gpio for hog
In-Reply-To: <1368070143-1655-1-git-send-email-b32955@freescale.com>
References: <1368070143-1655-1-git-send-email-b32955@freescale.com>
Message-ID: <1368070143-1655-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPI/NOR needs this gpio for CS.
So add this gpio in the hog pinctrl.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6dl-sabreauto.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-sabreauto.dts b/arch/arm/boot/dts/imx6dl-sabreauto.dts
index 7adcec3..60f3038 100644
--- a/arch/arm/boot/dts/imx6dl-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6dl-sabreauto.dts
@@ -25,6 +25,7 @@
 			fsl,pins = <
 				MX6DL_PAD_NANDF_CS2__GPIO6_IO15 0x80000000
 				MX6DL_PAD_SD2_DAT2__GPIO1_IO13  0x80000000
+				MX6DL_PAD_EIM_D19__GPIO3_IO19 	0x80000000
 			>;
 		};
 	};
-- 
1.7.1
