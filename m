From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 23 Mar 2016 23:24:19 +0100
Subject: [PATCH 2/4] arm64: dts: marvell: Rename armada-37xx USB node
In-Reply-To: <1458771861-12392-1-git-send-email-afaerber@suse.de>
References: <1458771861-12392-1-git-send-email-afaerber@suse.de>
Message-ID: <1458771861-12392-3-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need to reflect the USB version in the node name.

Fixes: adbc3695d9e4 ("arm64: dts: add the Marvell Armada 3700 family and a development board")
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 4328c2408a8a..55a861d60fae 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -105,7 +105,7 @@
 				status = "disabled";
 			};
 
-			usb3: usb3 at 58000 {
+			usb3: usb at 58000 {
 				compatible = "generic-xhci";
 				reg = <0x58000 0x4000>;
 				interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.6.2
