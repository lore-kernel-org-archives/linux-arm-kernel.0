From: bruherrera@gmail.com (Bruno Herrera)
Date: Tue, 21 Jun 2016 22:27:06 -0300
Subject: [PATCH] ARM: dts: stm32f469-disco: Fix memory size from 8Mb to 16Mb
Message-ID: <1466558826-3078-1-git-send-email-bruherrera@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bruno Herrera <bruherrera@gmail.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index e911af8..83ee90d 100644
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
2.7.4 (Apple Git-66)
