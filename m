From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 20 Feb 2014 13:14:43 +0800
Subject: [PATCH v10 14/15] ARM: dts: imx6: add anatop phandle for usbphy
In-Reply-To: <1392873284-9386-1-git-send-email-peter.chen@freescale.com>
References: <1392873284-9386-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1392873284-9386-15-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add anatop phandle for usbphy

Signed-off-by: Peter Chen <peter.chen@freescale.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    2 ++
 arch/arm/boot/dts/imx6sl.dtsi  |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index fb28b2e..047b147 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -557,6 +557,7 @@
 				reg = <0x020c9000 0x1000>;
 				interrupts = <0 44 0x04>;
 				clocks = <&clks 182>;
+				fsl,anatop = <&anatop>;
 			};
 
 			usbphy2: usbphy at 020ca000 {
@@ -564,6 +565,7 @@
 				reg = <0x020ca000 0x1000>;
 				interrupts = <0 45 0x04>;
 				clocks = <&clks 183>;
+				fsl,anatop = <&anatop>;
 			};
 
 			snvs at 020cc000 {
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 28558f1..30322b5 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -489,6 +489,7 @@
 				reg = <0x020c9000 0x1000>;
 				interrupts = <0 44 0x04>;
 				clocks = <&clks IMX6SL_CLK_USBPHY1>;
+				fsl,anatop = <&anatop>;
 			};
 
 			usbphy2: usbphy at 020ca000 {
@@ -496,6 +497,7 @@
 				reg = <0x020ca000 0x1000>;
 				interrupts = <0 45 0x04>;
 				clocks = <&clks IMX6SL_CLK_USBPHY2>;
+				fsl,anatop = <&anatop>;
 			};
 
 			snvs at 020cc000 {
-- 
1.7.8
