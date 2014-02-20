From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 20 Feb 2014 13:14:42 +0800
Subject: [PATCH v10 13/15] ARM: dts: mxs: add mxs phy controller id
In-Reply-To: <1392873284-9386-1-git-send-email-peter.chen@freescale.com>
References: <1392873284-9386-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1392873284-9386-14-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to use controller id to access different register regions
for mxs phy.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23.dtsi |    1 +
 arch/arm/boot/dts/imx28.dtsi |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 581b754..8a99a64 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -23,6 +23,7 @@
 		serial1 = &auart1;
 		spi0 = &ssp0;
 		spi1 = &ssp1;
+		usbphy0 = &usbphy0;
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index f8e9b20..7da22b3 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -32,6 +32,8 @@
 		serial4 = &auart4;
 		spi0 = &ssp1;
 		spi1 = &ssp2;
+		usbphy0 = &usbphy0;
+		usbphy1 = &usbphy1;
 	};
 
 	cpus {
-- 
1.7.8
