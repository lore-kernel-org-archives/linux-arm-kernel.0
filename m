From: ynvich@gmail.com (Sergei Ianovich)
Date: Fri, 13 Dec 2013 06:27:10 +0400
Subject: [PATCH v2 01/16] ARM: dts: pxa2xx fix compatible strings
In-Reply-To: <1386901645-28895-1-git-send-email-ynvich@gmail.com>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <1386901645-28895-1-git-send-email-ynvich@gmail.com>
Message-ID: <1386901645-28895-2-git-send-email-ynvich@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
CC: Daniel Mack <zonque@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>
---
   v1..v2
   * no changes

 arch/arm/boot/dts/pxa2xx.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index a5e90f0..3419f87 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -18,7 +18,6 @@
 		serial1 = &btuart;
 		serial2 = &stuart;
 		serial3 = &hwuart;
-		i2c0 = &pwri2c;
 		i2c1 = &pxai2c1;
 	};
 
@@ -113,14 +112,14 @@
 		};
 
 		usb0: ohci at 4c000000 {
-			compatible = "mrvl,pxa-ohci";
+			compatible = "marvell,pxa-ohci";
 			reg = <0x4c000000 0x10000>;
 			interrupts = <3>;
 			status = "disabled";
 		};
 
 		mmc0: mmc at 41100000 {
-			compatible = "mrvl,pxa-mmc";
+			compatible = "marvell,pxa-mmc";
 			reg = <0x41100000 0x1000>;
 			interrupts = <23>;
 			status = "disabled";
-- 
1.8.4.3
