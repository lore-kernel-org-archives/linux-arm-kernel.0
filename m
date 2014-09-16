From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Sep 2014 18:18:02 +0200
Subject: [PATCH] ARM: dts: mmp2: Fix typo in max8925 compatible property
Message-ID: <1410884282-18041-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix typo in the compatible property for max8925 MFD driver. The proper
compatible as in Documentation and driver is 'maxim,max8925'.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/mmp2-brownstone.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
index 7f70a39459f6..29eeb465f99c 100644
--- a/arch/arm/boot/dts/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
@@ -30,7 +30,7 @@
 			twsi1: i2c at d4011000 {
 				status = "okay";
 				pmic: max8925 at 3c {
-					compatible = "maxium,max8925";
+					compatible = "maxim,max8925";
 					reg = <0x3c>;
 					interrupts = <1>;
 					interrupt-parent = <&intcmux4>;
-- 
1.9.1
