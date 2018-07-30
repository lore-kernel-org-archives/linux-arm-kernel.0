From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Mon, 30 Jul 2018 18:01:53 +0800
Subject: [PATCH 2/3] powerpc/mpc85xx: add clocks property for fman ptp timer
 node
In-Reply-To: <20180730100154.27906-1-yangbo.lu@nxp.com>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
Message-ID: <20180730100154.27906-2-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add clocks property for fman ptp timer node.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi   |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi   |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi  |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi  |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi |    1 +
 5 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
index 6b124f7..9b6cf91 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
@@ -100,4 +100,5 @@ ptp_timer0: ptp-timer at 4fe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x4fe000 0x1000>;
 	interrupts = <96 2 0 0>;
+	clocks = <&clockgen 3 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
index b80aaf5..e95c11f 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
@@ -100,4 +100,5 @@ ptp_timer1: ptp-timer at 5fe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x5fe000 0x1000>;
 	interrupts = <97 2 0 0>;
+	clocks = <&clockgen 3 1>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
index d3720fd..d62b36c 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
@@ -105,4 +105,5 @@ ptp_timer0: ptp-timer at 4fe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x4fe000 0x1000>;
 	interrupts = <96 2 0 0>;
+	clocks = <&clockgen 3 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
index ae34c20..3102324 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
@@ -105,4 +105,5 @@ ptp_timer1: ptp-timer at 5fe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x5fe000 0x1000>;
 	interrupts = <97 2 0 0>;
+	clocks = <&clockgen 3 1>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
index 02f2755..c90702b 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
@@ -93,4 +93,5 @@ ptp_timer0: ptp-timer at 4fe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x4fe000 0x1000>;
 	interrupts = <96 2 0 0>;
+	clocks = <&clockgen 3 0>;
 };
-- 
1.7.1
