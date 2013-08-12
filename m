From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 12 Aug 2013 12:14:27 +0800
Subject: [PATCH 2/2] ARM: dtsi: imx6qdl-sabresd: Add USB OTG vbus pin to
 pinctrl_hog
In-Reply-To: <1376280867-3259-1-git-send-email-peter.chen@freescale.com>
References: <1376280867-3259-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1376280867-3259-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB OTG vbus pin needs to be configured as gpio function at
sabresd board.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index b4db3f7..36cb44a 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -205,6 +205,7 @@
 				MX6QDL_PAD_NANDF_D3__GPIO2_IO03 	0x80000000
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1    	0x130b0
 				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x80000000
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x80000000
 			>;
 		};
 	};
-- 
1.7.1
