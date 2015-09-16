From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 16 Sep 2015 09:35:25 +0800
Subject: [PATCH] arm64: mt8173.dtsi: correct i2c node names
Message-ID: <1442367325-55819-1-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Node name in device tree should describe general class of the
device. Correct incorrect i2c node names.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
This is based on v4.3-rc1.
All the other i2c node names are correct.
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index d18ee42..7f360b7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -365,7 +365,7 @@
 			status = "disabled";
 		};
 
-		i2c3: i2c3 at 11010000 {
+		i2c3: i2c at 11010000 {
 			compatible = "mediatek,mt8173-i2c";
 			reg = <0 0x11010000 0 0x70>,
 			      <0 0x11000280 0 0x80>;
@@ -381,7 +381,7 @@
 			status = "disabled";
 		};
 
-		i2c4: i2c4 at 11011000 {
+		i2c4: i2c at 11011000 {
 			compatible = "mediatek,mt8173-i2c";
 			reg = <0 0x11011000 0 0x70>,
 			      <0 0x11000300 0 0x80>;
@@ -397,7 +397,7 @@
 			status = "disabled";
 		};
 
-		i2c6: i2c6 at 11013000 {
+		i2c6: i2c at 11013000 {
 			compatible = "mediatek,mt8173-i2c";
 			reg = <0 0x11013000 0 0x70>,
 			      <0 0x11000080 0 0x80>;
-- 
1.9.1
