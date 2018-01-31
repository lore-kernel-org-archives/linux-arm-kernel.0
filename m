From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Wed, 31 Jan 2018 20:31:26 +0100
Subject: [PATCH] arm: dts: sun7i: include correct ccu clock header
Message-ID: <1517427086-66480-1-git-send-email-giulio.benetti@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include correct clock header sun7i-a20-ccu.h
instead of sun4i-a20-ccu.h.

Including sun4i header instead of sun7i
prevents using sun7i specific defines.

Substitute header inclusion in sun7i-a20.dtsi
using right one.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 1aa05a0..d0865d2 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -47,7 +47,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/dma/sun4i-a10.h>
-#include <dt-bindings/clock/sun4i-a10-ccu.h>
+#include <dt-bindings/clock/sun7i-a20-ccu.h>
 #include <dt-bindings/reset/sun4i-a10-ccu.h>
 
 / {
-- 
2.7.4
