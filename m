From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Wed, 10 Oct 2012 17:35:15 +0530
Subject: [PATCH 2/3] ARM: dts: Correcting size of memory defined for omap5
In-Reply-To: <1349870716-25511-1-git-send-email-lokeshvutla@ti.com>
References: <1349870716-25511-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1349870716-25511-3-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Memory present for omap5 is 2GB. But in dt file
it is specified as 1GB. Correcting the same
in this patch

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/boot/dts/omap5-evm.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index 9c41a3f..6f87e1a 100644
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
1.7.10.4
