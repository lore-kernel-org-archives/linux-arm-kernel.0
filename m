From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 29 Aug 2016 04:41:50 +0300
Subject: [PATCH] ARM: dts: imx7d-sdb: fix ti,x-plate-ohms property name
Message-ID: <1472434910-29071-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix misspelled "ti,x-plate-ohms" property name of TI TSC2046
touchscreen controller.

Fixes: d09e6beafa23 ("ARM: dts: imx7d-sdb: Add support for touchscreen")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 95ee268..2f33c46 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -131,7 +131,7 @@
 		ti,y-min = /bits/ 16 <0>;
 		ti,y-max = /bits/ 16 <0>;
 		ti,pressure-max = /bits/ 16 <0>;
-		ti,x-plat-ohms = /bits/ 16 <400>;
+		ti,x-plate-ohms = /bits/ 16 <400>;
 		wakeup-source;
 	};
 };
-- 
2.8.1
