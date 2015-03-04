From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  4 Mar 2015 17:26:00 +0100
Subject: [PATCH] ARM: at91/dt: fix lcdck declaration
Message-ID: <1425486360-21799-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

lcdck clk is assigned id 3 and not 4.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index aa4b829..1273af4 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -461,7 +461,7 @@
 
 					lcdck: lcdck {
 						#clock-cells = <0>;
-						reg = <4>;
+						reg = <3>;
 						clocks = <&mck>;
 					};
 
-- 
1.9.1
