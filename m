From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 23 Aug 2014 10:11:31 +0100
Subject: [PATCH 3/6] ARM: dts: hummingboard/cubox-i: change SPDIF output to be
 more descriptive
In-Reply-To: <20140823091058.GO30401@n2100.arm.linux.org.uk>
References: <20140823091058.GO30401@n2100.arm.linux.org.uk>
Message-ID: <E1XL7MB-0002yL-R3@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6dl-hummingboard.dts | 2 +-
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-hummingboard.dts b/arch/arm/boot/dts/imx6dl-hummingboard.dts
index d1c892e28296..71598546087f 100644
--- a/arch/arm/boot/dts/imx6dl-hummingboard.dts
+++ b/arch/arm/boot/dts/imx6dl-hummingboard.dts
@@ -58,7 +58,7 @@
 
 	sound-spdif {
 		compatible = "fsl,imx-audio-spdif";
-		model = "imx-spdif";
+		model = "On-board SPDIF";
 		/* IMX6 doesn't implement this yet */
 		spdif-controller = <&spdif>;
 		spdif-out;
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index 298d0fdf8ebe..6a524ca011e7 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -61,7 +61,7 @@
 
 	sound-spdif {
 		compatible = "fsl,imx-audio-spdif";
-		model = "imx-spdif";
+		model = "Integrated SPDIF";
 		/* IMX6 doesn't implement this yet */
 		spdif-controller = <&spdif>;
 		spdif-out;
-- 
1.8.3.1
