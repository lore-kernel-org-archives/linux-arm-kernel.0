From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 31 Jul 2014 18:42:19 +0200
Subject: [PATCH 3/7] arm: dts: mt6589: Fix typo in GIC unit address
In-Reply-To: <1406824943-24052-1-git-send-email-matthias.bgg@gmail.com>
References: <1406824943-24052-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1406824943-24052-4-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changes the unit address of the gic node to it's first register area.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm/boot/dts/mt6589.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mt6589.dtsi b/arch/arm/boot/dts/mt6589.dtsi
index d0297a0..742c9bd 100644
--- a/arch/arm/boot/dts/mt6589.dtsi
+++ b/arch/arm/boot/dts/mt6589.dtsi
@@ -81,7 +81,7 @@
 			clock-names = "system-clk", "rtc-clk";
 		};
 
-		gic: interrupt-controller at 10212000 {
+		gic: interrupt-controller at 10211000 {
 			compatible = "arm,cortex-a15-gic";
 			interrupt-controller;
 			#interrupt-cells = <3>;
-- 
1.7.9.5
