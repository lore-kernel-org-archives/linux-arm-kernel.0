From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 17 Sep 2018 13:23:03 +0200
Subject: [PATCH] DT: marvell,mmp2: give gpio node a name
Message-ID: <20180917112303.8701-1-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be useful for boards that actually use GPIO pins.

Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 766bbb8495b6..f8867364e5a1 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -168,7 +168,7 @@
 				status = "disabled";
 			};
 
-			gpio at d4019000 {
+			gpio: gpio at d4019000 {
 				compatible = "marvell,mmp2-gpio";
 				#address-cells = <1>;
 				#size-cells = <1>;
-- 
2.17.1
