From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon,  7 Aug 2017 12:52:39 +0530
Subject: [PATCH 07/10] ARM: dts: imx6q-apalis-ixora: add camera i2c bus
 definition
In-Reply-To: <cover.1502087184.git.maitysanchayan@gmail.com>
References: <cover.1502087184.git.maitysanchayan@gmail.com>
Message-ID: <45f7597c0a78f23b9f163b381e80b536de93ca3b.1502087184.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
 arch/arm/boot/dts/imx6q-apalis-ixora.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index ebe5b909c6f9..73c1ec883ff5 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -185,6 +185,14 @@
 	};
 };
 
+/*
+ * I2C3_SDA/SCL (CAM) on MXM3 pin 201/203 (e.g. camera sensor on carrier
+ * board)
+ */
+&i2c3 {
+	status = "okay";
+};
+
 &ipu1_di1_disp1 {
 	remote-endpoint = <&lcd_display_in>;
 };
-- 
2.13.3
