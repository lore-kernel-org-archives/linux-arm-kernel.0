From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed, 15 Feb 2017 18:19:06 -0800
Subject: [PATCH v4 04/36] ARM: dts: imx6qdl: add capture-subsystem device
In-Reply-To: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1487211578-11360-5-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 arch/arm/boot/dts/imx6dl.dtsi | 5 +++++
 arch/arm/boot/dts/imx6q.dtsi  | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 371288a..f1743fc 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -100,6 +100,11 @@
 		};
 	};
 
+	capture-subsystem {
+		compatible = "fsl,imx-capture-subsystem";
+		ports = <&ipu1_csi0>, <&ipu1_csi1>;
+	};
+
 	display-subsystem {
 		compatible = "fsl,imx-display-subsystem";
 		ports = <&ipu1_di0>, <&ipu1_di1>;
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index b833b0d..4cc6579 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -206,6 +206,11 @@
 		};
 	};
 
+	capture-subsystem {
+		compatible = "fsl,imx-capture-subsystem";
+		ports = <&ipu1_csi0>, <&ipu1_csi1>, <&ipu2_csi0>, <&ipu2_csi1>;
+	};
+
 	display-subsystem {
 		compatible = "fsl,imx-display-subsystem";
 		ports = <&ipu1_di0>, <&ipu1_di1>, <&ipu2_di0>, <&ipu2_di1>;
-- 
2.7.4
