From: sumit.garg@nxp.com (Sumit Garg)
Date: Sat, 9 Sep 2017 05:03:28 +0530
Subject: [PATCH] arm64: dts: ls: Add optee node
Message-ID: <1504913608-21804-1-git-send-email-sumit.garg@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add optee device tree node on ls1012a, ls1043a, ls1046a, ls1088a
and ls208xa.

Signed-off-by: Sumit Garg <sumit.garg@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 7 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 7 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 7 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 7 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 7 +++++++
 5 files changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index df83915..a1764d3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -472,4 +472,11 @@
 			phy_type = "ulpi";
 		};
 	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 31fd77f..e6be740 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -749,6 +749,13 @@
 		};
 	};
 
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
 };
 
 #include "qoriq-qman-portals.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index dc1640b..7c30401 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -658,6 +658,13 @@
 			no-map;
 		};
 	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
 };
 
 #include "qoriq-qman-portals.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 33797b3..253df8a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -436,4 +436,11 @@
 		};
 	};
 
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 4fb9a09..f3a40af 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -786,4 +786,11 @@
 		interrupts = <0 18 0x4>;
 		little-endian;
 	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
 };
-- 
1.9.1
