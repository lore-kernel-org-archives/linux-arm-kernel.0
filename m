From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  8 Sep 2014 11:19:18 +0200
Subject: [PATCH v2 3/5] ARM: mvebu: Change vendor prefix for Intersil
 Corporation to isil
In-Reply-To: <1410167960-554-1-git-send-email-p.zabel@pengutronix.de>
References: <1410167960-554-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1410167960-554-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there is a wild mixture of isl, isil, and intersil
compatibles in the kernel. At this point, changing the vendor
symbol to the most often used variant, which is equal to the
NASDAQ symbol, isil, should not hurt.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/armada-370-netgear-rn102.dts | 2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts | 2 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index d6d572e..edc381c 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -122,7 +122,7 @@
 				status = "okay";
 
 				isl12057: isl12057 at 68 {
-					compatible = "isl,isl12057";
+					compatible = "isil,isl12057";
 					reg = <0x68>;
 				};
 
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index c5fe8b5..7367b4c 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -117,7 +117,7 @@
 				status = "okay";
 
 				isl12057: isl12057 at 68 {
-					compatible = "isl,isl12057";
+					compatible = "isil,isl12057";
 					reg = <0x68>;
 				};
 
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index 0cf999a..252def8 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -174,7 +174,7 @@
 				status = "okay";
 
 				isl12057: isl12057 at 68 {
-					compatible = "isl,isl12057";
+					compatible = "isil,isl12057";
 					reg = <0x68>;
 				};
 
-- 
2.1.0.rc1
