From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:41 +0200
Subject: [PATCH v2 16/30] ARM: shmobile: r8a7740: Add SCIF nodes
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-17-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This describes all of the SCIF hardware of the r8a7740.
Each node is disabled and may be enabled as necessary
by board DTS files.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/boot/dts/r8a7740.dtsi | 63 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 55d29f4..bda18fb 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -156,6 +156,69 @@
 		status = "disabled";
 	};
 
+	scifa0: serial at e6c40000 {
+		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
+		reg = <0xe6c40000 0x100>;
+		interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifa1: serial at e6c50000 {
+		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
+		reg = <0xe6c50000 0x100>;
+		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifa2: serial at e6c60000 {
+		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
+		reg = <0xe6c60000 0x100>;
+		interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifa3: serial at e6c70000 {
+		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
+		reg = <0xe6c70000 0x100>;
+		interrupts = <0 103 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifa4: serial at e6c80000 {
+		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
+		reg = <0xe6c80000 0x100>;
+		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifa5: serial at e6cb0000 {
+		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
+		reg = <0xe6cb0000 0x100>;
+		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifa6: serial at e6cc0000 {
+		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
+		reg = <0xe6cc0000 0x100>;
+		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifa7: serial at e6cd0000 {
+		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
+		reg = <0xe6cd0000 0x100>;
+		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifb8: serial at e6c30000 {
+		compatible = "renesas,scifb-r8a7740", "renesas,scifb";
+		reg = <0xe6c30000 0x100>;
+		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	pfc: pfc at e6050000 {
 		compatible = "renesas,pfc-r8a7740";
 		reg = <0xe6050000 0x8000>,
-- 
2.0.0.rc2
