From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 5 Nov 2012 18:22:50 +0530
Subject: [PATCH V3 1/3] ARM: dts: omap5-evm: Fix size of memory defined for EVM
In-Reply-To: <1352119972-13710-1-git-send-email-lokeshvutla@ti.com>
References: <1352119972-13710-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1352119972-13710-2-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Memory present for OMAP5-evm is 2GB. But in dts file
it is specified as 1GB. Correcting the same.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/boot/dts/omap5-evm.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index c663eba..88d3d9b8 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -15,7 +15,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x80000000 0x40000000>; /* 1 GB */
+		reg = <0x80000000 0x80000000>; /* 2 GB */
 	};
 
 	vmmcsd_fixed: fixedregulator-mmcsd {
-- 
1.7.9.5
