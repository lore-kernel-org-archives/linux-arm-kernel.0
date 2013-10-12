From: peter.chen@freescale.com (Peter Chen)
Date: Sat, 12 Oct 2013 17:09:44 +0800
Subject: [PATCH 10/12] ARM: dts: imx6: add anatop phandle for usbphy
In-Reply-To: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
References: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1381568986-19802-11-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add anatop phandle for usbphy

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ef51342..145ece2 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -541,6 +541,7 @@
 				reg = <0x020c9000 0x1000>;
 				interrupts = <0 44 0x04>;
 				clocks = <&clks 182>;
+				fsl,anatop = <&anatop>;
 			};
 
 			usbphy2: usbphy at 020ca000 {
@@ -548,6 +549,7 @@
 				reg = <0x020ca000 0x1000>;
 				interrupts = <0 45 0x04>;
 				clocks = <&clks 183>;
+				fsl,anatop = <&anatop>;
 			};
 
 			snvs at 020cc000 {
-- 
1.7.1
