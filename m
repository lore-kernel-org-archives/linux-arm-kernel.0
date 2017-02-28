From: florian.vaussard@gmail.com (Florian Vaussard)
Date: Tue, 28 Feb 2017 16:52:11 +0100
Subject: [PATCH 1/2] ARM: dts: socfpga: Add labels for CPU nodes
In-Reply-To: <1488297132-21553-1-git-send-email-florian.vaussard@heig-vd.ch>
References: <1488297132-21553-1-git-send-email-florian.vaussard@heig-vd.ch>
Message-ID: <1488297132-21553-2-git-send-email-florian.vaussard@heig-vd.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes it easier to reference the CPU nodes afterwards.

Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 arch/arm/boot/dts/socfpga.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 2c43c4d..478047e 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -38,13 +38,13 @@
 		#size-cells = <0>;
 		enable-method = "altr,socfpga-smp";
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <0>;
 			next-level-cache = <&L2>;
 		};
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <1>;
-- 
2.7.4
