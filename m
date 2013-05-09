From: b32955@freescale.com (Huang Shijie)
Date: Thu, 9 May 2013 11:29:02 +0800
Subject: [PATCH 4/5] ARM: dts: imx6q: add a gpio for hog
In-Reply-To: <1368070143-1655-1-git-send-email-b32955@freescale.com>
References: <1368070143-1655-1-git-send-email-b32955@freescale.com>
Message-ID: <1368070143-1655-5-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPI/NOR needs this gpio for CS.
So add this gpio in the hog pinctrl.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabreauto.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dts b/arch/arm/boot/dts/imx6q-sabreauto.dts
index 49d6f28..9fb3e99 100644
--- a/arch/arm/boot/dts/imx6q-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6q-sabreauto.dts
@@ -29,6 +29,7 @@
 			fsl,pins = <
 				MX6Q_PAD_NANDF_CS2__GPIO6_IO15 0x80000000
 				MX6Q_PAD_SD2_DAT2__GPIO1_IO13  0x80000000
+				MX6Q_PAD_EIM_D19__GPIO3_IO19   0x80000000
 			>;
 		};
 	};
-- 
1.7.1
