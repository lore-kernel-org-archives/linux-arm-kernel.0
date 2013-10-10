From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 10 Oct 2013 16:19:54 +0530
Subject: [PATCH 2/2] ARM: dts: omap5: Add dr_mode for dwc3
In-Reply-To: <1381402195-29257-1-git-send-email-kishon@ti.com>
References: <1381402195-29257-1-git-send-email-kishon@ti.com>
Message-ID: <1381402195-29257-2-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: George Cherian <george.cherian@ti.com>

Added dr_mode property in dwc3 and set its default mode to device.

Signed-off-by: George Cherian <george.cherian@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 6d0a1d5..ef598af 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -652,6 +652,7 @@
 				reg = <0x4a030000 0x10000>;
 				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 				usb-phy = <&usb2_phy>, <&usb3_phy>;
+				dr_mode = "peripheral";
 				tx-fifo-resize;
 			};
 		};
-- 
1.7.10.4
