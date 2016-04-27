From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 Apr 2016 17:46:28 +0200
Subject: [PATCH 2/3] arm64: dts: marvell: Rename armada-37xx USB node
In-Reply-To: <1461771989-15662-1-git-send-email-gregory.clement@free-electrons.com>
References: <1461771989-15662-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1461771989-15662-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas F?rber <afaerber@suse.de>

No need to reflect the USB version in the node name.

Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
[gregory.clement at free-electrons.com: drop Fixes tag as it is not a bug fix.]
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
2.5.0
