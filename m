From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 5 Aug 2012 14:01:28 +0800
Subject: [PATCH 4/4] ARM: dts: imx: add alias for gpio
In-Reply-To: <1344146488-9496-1-git-send-email-shawn.guo@linaro.org>
References: <1344146488-9496-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344146488-9496-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add alias for gpio nodes, so that gpio driver can identify the port
number and then specify a sensible gpio base rather than using the
one dynamically allocated by gpio core.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx27.dtsi |    6 ++++++
 arch/arm/boot/dts/imx51.dtsi |    4 ++++
 arch/arm/boot/dts/imx53.dtsi |    7 +++++++
 arch/arm/boot/dts/imx6q.dtsi |    7 +++++++
 4 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 00bae3a..5303ab6 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -19,6 +19,12 @@
 		serial3 = &uart4;
 		serial4 = &uart5;
 		serial5 = &uart6;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		gpio5 = &gpio6;
 	};
 
 	avic: avic-interrupt-controller at e0000000 {
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 53cbaa3..aba28dc 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -17,6 +17,10 @@
 		serial0 = &uart1;
 		serial1 = &uart2;
 		serial2 = &uart3;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
 	};
 
 	tzic: tz-interrupt-controller at e0000000 {
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index fc79cdc..cd37165 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -19,6 +19,13 @@
 		serial2 = &uart3;
 		serial3 = &uart4;
 		serial4 = &uart5;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		gpio5 = &gpio6;
+		gpio6 = &gpio7;
 	};
 
 	tzic: tz-interrupt-controller at 0fffc000 {
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 3d3c64b..fd57079 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -19,6 +19,13 @@
 		serial2 = &uart3;
 		serial3 = &uart4;
 		serial4 = &uart5;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		gpio5 = &gpio6;
+		gpio6 = &gpio7;
 	};
 
 	cpus {
-- 
1.7.5.4
