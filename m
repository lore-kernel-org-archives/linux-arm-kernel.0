From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:19:33 +0900
Subject: [PATCH 03/21] ARM: shmobile: r8a73a4: Specify PFC interrupts in DT
In-Reply-To: <cover.1387893834.git.horms+renesas@verge.net.au>
References: <cover.1387893834.git.horms+renesas@verge.net.au>
Message-ID: <defc82eabf962b83ac9e112238baa895890645ea.1387893834.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 6b7ce89..62d0211 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -288,6 +288,22 @@
 		reg = <0 0xe6050000 0 0x9000>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupts-extended =
+			<&irqc0  0 0>, <&irqc0  1 0>, <&irqc0  2 0>, <&irqc0  3 0>,
+			<&irqc0  4 0>, <&irqc0  5 0>, <&irqc0  6 0>, <&irqc0  7 0>,
+			<&irqc0  8 0>, <&irqc0  9 0>, <&irqc0 10 0>, <&irqc0 11 0>,
+			<&irqc0 12 0>, <&irqc0 13 0>, <&irqc0 14 0>, <&irqc0 15 0>,
+			<&irqc0 16 0>, <&irqc0 17 0>, <&irqc0 18 0>, <&irqc0 19 0>,
+			<&irqc0 20 0>, <&irqc0 21 0>, <&irqc0 22 0>, <&irqc0 23 0>,
+			<&irqc0 24 0>, <&irqc0 25 0>, <&irqc0 26 0>, <&irqc0 27 0>,
+			<&irqc0 28 0>, <&irqc0 29 0>, <&irqc0 30 0>, <&irqc0 31 0>,
+			<&irqc1  0 0>, <&irqc1  1 0>, <&irqc1  2 0>, <&irqc1  3 0>,
+			<&irqc1  4 0>, <&irqc1  5 0>, <&irqc1  6 0>, <&irqc1  7 0>,
+			<&irqc1  8 0>, <&irqc1  9 0>, <&irqc1 10 0>, <&irqc1 11 0>,
+			<&irqc1 12 0>, <&irqc1 13 0>, <&irqc1 14 0>, <&irqc1 15 0>,
+			<&irqc1 16 0>, <&irqc1 17 0>, <&irqc1 18 0>, <&irqc1 19 0>,
+			<&irqc1 20 0>, <&irqc1 21 0>, <&irqc1 22 0>, <&irqc1 23 0>,
+			<&irqc1 24 0>, <&irqc1 25 0>;
 	};
 
 	sdhi0: sd at ee100000 {
-- 
1.8.4
