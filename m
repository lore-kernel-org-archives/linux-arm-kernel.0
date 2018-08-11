From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 11 Aug 2018 13:25:10 +0200
Subject: [PATCH] ARM: dts: stout: Add DA9063 OnKey node
Message-ID: <20180811112510.18299-1-marek.vasut+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DA9063 OnKey subnode to DA9063 PMIC node on Stout.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc at vger.kernel.org
---
 arch/arm/boot/dts/r8a7790-stout.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-stout.dts b/arch/arm/boot/dts/r8a7790-stout.dts
index a13a92c26645..629da4cee1b9 100644
--- a/arch/arm/boot/dts/r8a7790-stout.dts
+++ b/arch/arm/boot/dts/r8a7790-stout.dts
@@ -318,6 +318,10 @@
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 
+		onkey {
+			compatible = "dlg,da9063-onkey";
+		};
+
 		rtc {
 			compatible = "dlg,da9063-rtc";
 		};
-- 
2.16.2
