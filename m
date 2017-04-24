From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Mon, 24 Apr 2017 15:22:02 -0500
Subject: [PATCH v2 2/4] ARM: dts: k2g-evm: Add unit address to memory node
In-Reply-To: <20170424202204.24170-1-fcooper@ti.com>
References: <20170424202204.24170-1-fcooper@ti.com>
Message-ID: <20170424202204.24170-3-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the new Keystone 2 Industrial Communication EVM adding the
unit address to the memory node it made sense to add it for this board
also.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 692fcbb..61883cb 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -20,7 +20,7 @@
 	compatible =  "ti,k2g-evm", "ti,k2g", "ti,keystone";
 	model = "Texas Instruments K2G General Purpose EVM";
 
-	memory {
+	memory at 800000000 {
 		device_type = "memory";
 		reg = <0x00000008 0x00000000 0x00000000 0x80000000>;
 	};
-- 
2.10.0
