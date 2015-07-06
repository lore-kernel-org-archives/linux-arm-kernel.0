From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 6 Jul 2015 17:50:33 +0800
Subject: [PATCH 1/2] arm: dts: berlin: add aliases for serial
In-Reply-To: <1436176234-819-1-git-send-email-jszhang@marvell.com>
References: <1436176234-819-1-git-send-email-jszhang@marvell.com>
Message-ID: <1436176234-819-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is to prepare for the using stdout-path in next commit.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2.dtsi   | 6 ++++++
 arch/arm/boot/dts/berlin2cd.dtsi | 5 +++++
 arch/arm/boot/dts/berlin2q.dtsi  | 5 +++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index ef811de..40cf262 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -47,6 +47,12 @@
 	model = "Marvell Armada 1500 (BG2) SoC";
 	compatible = "marvell,berlin2", "marvell,berlin";
 
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 900213d..6246aec 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -47,6 +47,11 @@
 	model = "Marvell Armada 1500-mini (BG2CD) SoC";
 	compatible = "marvell,berlin2cd", "marvell,berlin";
 
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 63a4849..380fa18 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -43,6 +43,11 @@
 	model = "Marvell Armada 1500 pro (BG2-Q) SoC";
 	compatible = "marvell,berlin2q", "marvell,berlin";
 
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.1.4
