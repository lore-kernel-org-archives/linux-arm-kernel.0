From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 12 Nov 2018 04:20:12 +0100
Subject: [PATCH v3 03/18] DT: marvell,mmp2: give gpio node a name
In-Reply-To: <20181112032027.653931-1-lkundrak@v3.sk>
References: <20181112032027.653931-1-lkundrak@v3.sk>
Message-ID: <20181112032027.653931-4-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be useful for boards that actually use GPIO pins.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/boot/dts/mmp2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index db15d1186cd0..f2a18779de7c 100644
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
2.19.1
