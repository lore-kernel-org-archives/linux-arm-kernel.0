From: lho@apm.com (Loc Ho)
Date: Thu,  8 May 2014 17:03:19 -0600
Subject: [PATCH 4/4] arm64: Add APM X-Gene SoC EDAC DTS entries
In-Reply-To: <1399590199-12256-4-git-send-email-lho@apm.com>
References: <1399590199-12256-1-git-send-email-lho@apm.com>
 <1399590199-12256-2-git-send-email-lho@apm.com>
 <1399590199-12256-3-git-send-email-lho@apm.com>
 <1399590199-12256-4-git-send-email-lho@apm.com>
Message-ID: <1399590199-12256-5-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds APM X-Gene SoC EDAC DTS entries.

Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |   89 ++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 93f4b2d..aff6821 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -269,6 +269,95 @@
 			interrupts = <0x0 0x4c 0x4>;
 		};
 
+		edacmc0: edacmc0 at 7e800000 {
+			compatible = "apm,xgene-edac-mc";
+			reg = <0x0 0x78800000 0x0 0x1000>,
+			      <0x0 0x7e200000 0x0 0x1000>,
+			      <0x0 0x7e700000 0x0 0x1000>,
+			      <0x0 0x7e720000 0x0 0x1000>,
+			      <0x0 0x7e800000 0x0 0x1000>;
+			interrupts = <0x0 0x20 0x4>;
+		};
+
+		edacmc1: edacmc1 at 7e840000 {
+			compatible = "apm,xgene-edac-mc";
+			reg = <0x0 0x78800000 0x0 0x1000>,
+			      <0x0 0x7e200000 0x0 0x1000>,
+			      <0x0 0x7e700000 0x0 0x1000>,
+			      <0x0 0x7e720000 0x0 0x1000>,
+			      <0x0 0x7e840000 0x0 0x1000>;
+			interrupts = <0x0 0x20 0x4>;
+		};
+
+		edacmc2: edacmc2 at 7e880000 {
+			compatible = "apm,xgene-edac-mc";
+			reg = <0x0 0x78800000 0x0 0x1000>,
+			      <0x0 0x7e200000 0x0 0x1000>,
+			      <0x0 0x7e700000 0x0 0x1000>,
+			      <0x0 0x7e720000 0x0 0x1000>,
+			      <0x0 0x7e880000 0x0 0x1000>;
+			interrupts = <0x0 0x20 0x4>;
+		};
+
+		edacmc3: edacmc3 at 7e8c0000 {
+			compatible = "apm,xgene-edac-mc";
+			reg = <0x0 0x78800000 0x0 0x1000>,
+			      <0x0 0x7e200000 0x0 0x1000>,
+			      <0x0 0x7e700000 0x0 0x1000>,
+			      <0x0 0x7e720000 0x0 0x1000>,
+			      <0x0 0x7e8c0000 0x0 0x1000>;
+			interrupts = <0x0 0x20 0x4>;
+		};
+
+		edacpmd0: edacpmd0 at 7c000000 {
+			compatible = "apm,xgene-edac-pmd";
+			reg = <0x0 0x78800000 0x0 0x1000>,
+			      <0x0 0x7c000000 0x0 0x200000>;
+			interrupts = <0x0 0x20 0x4>,
+				     <0x0 0x21 0x4>;
+		};
+
+		edacpmd1: edacpmd1 at 7c200000 {
+			compatible = "apm,xgene-edac-pmd";
+			reg = <0x0 0x78800000 0x0 0x1000>,
+			      <0x0 0x7c200000 0x0 0x200000>;
+			interrupts = <0x0 0x20 0x4>,
+				     <0x0 0x21 0x4>;
+		};
+
+		edacpmd2: edacpmd2 at 7c400000 {
+			compatible = "apm,xgene-edac-pmd";
+			reg = <0x0 0x78800000 0x0 0x1000>,
+			      <0x0 0x7c400000 0x0 0x200000>;
+			interrupts = <0x0 0x20 0x4>,
+				     <0x0 0x21 0x4>;
+		};
+
+		edacpmd3: edacpmd3 at 7c600000 {
+			compatible = "apm,xgene-edac-pmd";
+			reg = <0x0 0x78800000 0x0 0x1000>,
+			      <0x0 0x7c600000 0x0 0x200000>;
+			interrupts = <0x0 0x20 0x4>,
+				     <0x0 0x21 0x4>;
+		};
+
+		edacl3: edacl3 at 7e600000 {
+			compatible = "apm,xgene-edac-l3";
+			reg = <0x0 0x78800000 0x0 0x1000>,
+			      <0x0 0x7e600000 0x0 0x1000>;
+			interrupts = <0x0 0x20 0x4>,
+				     <0x0 0x21 0x4>;
+		};
+
+		edacsoc: edacsoc at 7e930000 {
+			compatible = "apm,xgene-edac-soc";
+			reg = <0x0 0x78800000 0x0 0x1000>,
+			      <0x0 0x7e930000 0x0 0x1000>;
+			interrupts = <0x0 0x20 0x4>,
+				     <0x0 0x21 0x4>,
+				     <0x0 0x27 0x4>;
+		};
+
 		phy1: phy at 1f21a000 {
 			compatible = "apm,xgene-phy";
 			reg = <0x0 0x1f21a000 0x0 0x100>;
-- 
1.5.5
