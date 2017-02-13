From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 13 Feb 2017 12:01:54 +0100
Subject: [PATCH] ARM: dts: at91: Fix matrix compatible
Message-ID: <1486983714-13314-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The matrix node was defined before the documentation for the bus
matrix configuration was submitted. Patch the device tree to match
the DT doc.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 2188bbe2a0b8..dfcbf922cd95 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -295,7 +295,7 @@
 			};
 
 			matrix: matrix at ffffee00 {
-				compatible = "atmel,at91sam9260-bus-matrix", "syscon";
+				compatible = "atmel,at91sam9261-matrix", "syscon";
 				reg = <0xffffee00 0x200>;
 			};
 
-- 
2.7.4
