From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 24 Feb 2014 10:21:07 +0800
Subject: [PATCH v11 15/15] ARM: dts: imx6: add mxs phy controller id
In-Reply-To: <1393208467-6355-1-git-send-email-peter.chen@freescale.com>
References: <1393208467-6355-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1393208467-6355-16-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to use controller id to access different register regions
for mxs phy.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    2 ++
 arch/arm/boot/dts/imx6sl.dtsi  |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 047b147..581c4c9 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -33,6 +33,8 @@
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
+		usbphy0 = &usbphy1;
+		usbphy1 = &usbphy2;
 	};
 
 	intc: interrupt-controller at 00a01000 {
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 30322b5..a06d939 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -27,6 +27,8 @@
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
+		usbphy0 = &usbphy1;
+		usbphy1 = &usbphy2;
 	};
 
 	cpus {
-- 
1.7.8
