From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Tue,  6 Dec 2016 18:17:10 +0100
Subject: [PATCH 1/5] ARM: BCM5301X: Fix LAN LED labels for Luxul XWR-3100
Message-ID: <20161206171714.22738-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

They were named incorrectly most likely due to copy & paste mistake.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
index 2f4a651..93cc91d 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
@@ -31,13 +31,13 @@
 		};
 
 		lan3	{
-			label = "bcm53xx:green:lan1";
+			label = "bcm53xx:green:lan3";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-off";
 		};
 
 		lan4	{
-			label = "bcm53xx:green:lan0";
+			label = "bcm53xx:green:lan4";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-off";
 		};
@@ -49,7 +49,7 @@
 		};
 
 		lan1	{
-			label = "bcm53xx:green:lan3";
+			label = "bcm53xx:green:lan1";
 			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-off";
 		};
-- 
2.10.1
