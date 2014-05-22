From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 22 May 2014 14:33:17 +0200
Subject: [PATCH 2/2] ARM: shmobile: marzen dts: Remove superfluous include
In-Reply-To: <1400761997-13512-1-git-send-email-geert+renesas@glider.be>
References: <1400761997-13512-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1400761997-13512-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<dt-bindings/interrupt-controller/irq.h> is already included by
r8a7779.dtsi.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 321290828eee..649129906d6f 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -12,7 +12,6 @@
 /dts-v1/;
 #include "r8a7779.dtsi"
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "marzen";
-- 
1.9.1
