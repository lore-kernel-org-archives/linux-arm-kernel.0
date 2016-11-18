From: bruherrera@gmail.com (Bruno Meirelles Herrera)
Date: Fri, 18 Nov 2016 12:58:45 -0200
Subject: [RESEND PATCH] ARM: dts: stm32f469-disco: Fix memory size from 8MB to
 16MB
Message-ID: <20161118145845.30455-1-bmh@certi.org.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bruno Herrera <bruherrera@gmail.com>

This patch fix memory size to support 16MB of external SDRAM.

Signed-off-by: Bruno Herrera <bruherrera@gmail.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 75f4303..fda12a4 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -58,7 +58,7 @@
 	};
 
 	memory {
-		reg = <0x00000000 0x800000>;
+		reg = <0x00000000 0x1000000>;
 	};
 
 	aliases {
-- 
2.9.3 (Apple Git-75)
