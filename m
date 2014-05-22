From: tharvey@gateworks.com (Tim Harvey)
Date: Wed, 21 May 2014 23:04:54 -0700
Subject: [PATCH 2/3] ARM: dts: imx6: ventana: change sound device name
In-Reply-To: <1400738695-32663-1-git-send-email-tharvey@gateworks.com>
References: <1400738695-32663-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1400738695-32663-2-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'model' property in the imx-audio-sgtl5000 binding specifies the
user-visible name of the audio device. This should be something common and
not baseboard specific.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6q-gw5400-a.dts  | 4 ++--
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 4 ++--
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 4 ++--
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index e51bb3f..1ead807 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -115,9 +115,9 @@
 	};
 
 	sound {
-		compatible = "fsl,imx6q-sabrelite-sgtl5000",
+		compatible = "fsl,imx6q-ventana-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
-		model = "imx6q-sabrelite-sgtl5000";
+		model = "sgtl5000-audio";
 		ssi-controller = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 035d3a8..fd9f6b7 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -114,9 +114,9 @@
 	};
 
 	sound {
-		compatible = "fsl,imx6q-sabrelite-sgtl5000",
+		compatible = "fsl,imx6q-ventana-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
-		model = "imx6q-sabrelite-sgtl5000";
+		model = "sgtl5000-audio";
 		ssi-controller = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index c8e5ae0..4b9aeb1 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -117,9 +117,9 @@
 	};
 
 	sound {
-		compatible = "fsl,imx6q-sabrelite-sgtl5000",
+		compatible = "fsl,imx6q-ventana-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
-		model = "imx6q-sabrelite-sgtl5000";
+		model = "sgtl5000-audio";
 		ssi-controller = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 2795dfc..8e1a869 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -107,9 +107,9 @@
 	};
 
 	sound {
-		compatible = "fsl,imx6q-sabrelite-sgtl5000",
+		compatible = "fsl,imx6q-ventana-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
-		model = "imx6q-sabrelite-sgtl5000";
+		model = "sgtl5000-audio";
 		ssi-controller = <&ssi1>;
 		audio-codec = <&codec>;
 		audio-routing =
-- 
1.8.3.2
