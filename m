From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 08:47:38 +0200
Subject: [PATCH 3/3] ARM: shmobile: r8a7779: Consistently use tabs for
 indentation
In-Reply-To: <1404715658-31050-1-git-send-email-horms+renesas@verge.net.au>
References: <1404715658-31050-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404715658-31050-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unify white space usage by consistently using tabs for indentation.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 94e2fc8..58d0d95 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -54,13 +54,13 @@
 		spi2 = &hspi2;
 	};
 
-        gic: interrupt-controller at f0001000 {
-                compatible = "arm,cortex-a9-gic";
-                #interrupt-cells = <3>;
-                interrupt-controller;
-                reg = <0xf0001000 0x1000>,
-                      <0xf0000100 0x100>;
-        };
+	gic: interrupt-controller at f0001000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0xf0001000 0x1000>,
+		      <0xf0000100 0x100>;
+	};
 
 	gpio0: gpio at ffc40000 {
 		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
-- 
2.0.0.rc2
