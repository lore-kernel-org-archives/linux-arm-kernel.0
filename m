From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 30 Jun 2014 23:57:54 +0200
Subject: [PATCH 4/9] ARM: dts: sun7i: Rename sun7i-a20-ir to sun4i-a10-ir
In-Reply-To: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
References: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1404165479-23785-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun7i block is the same as the one in the sun4i, rename the compatible
to reflect this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

--

I've already included the matching change to sunxi-cir.c in my pull-req to
Mauro.
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 7597ac1..66ffb3f 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -785,7 +785,7 @@
 		};
 
 		ir0: ir at 01c21800 {
-			compatible = "allwinner,sun7i-a20-ir";
+			compatible = "allwinner,sun4i-a10-ir";
 			clocks = <&apb0_gates 6>, <&ir0_clk>;
 			clock-names = "apb", "ir";
 			interrupts = <0 5 4>;
@@ -794,7 +794,7 @@
 		};
 
 		ir1: ir at 01c21c00 {
-			compatible = "allwinner,sun7i-a20-ir";
+			compatible = "allwinner,sun4i-a10-ir";
 			clocks = <&apb0_gates 7>, <&ir1_clk>;
 			clock-names = "apb", "ir";
 			interrupts = <0 6 4>;
-- 
2.0.0
