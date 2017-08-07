From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon,  7 Aug 2017 12:52:37 +0530
Subject: [PATCH 05/10] ARM: dts: imx6qdl-apalis: reword cam i2c comment
In-Reply-To: <cover.1502087184.git.maitysanchayan@gmail.com>
References: <cover.1502087184.git.maitysanchayan@gmail.com>
Message-ID: <2e757a46f34864825add3bc7996ea70578e34134.1502087184.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index bad86a0ebd82..6658c659b7d7 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -371,7 +371,8 @@
 };
 
 /*
- * GEN2_I2C, CAM: I2C3_SDA/SCL on MXM3 201/203 (unused)
+ * I2C3_SDA/SCL (CAM) on MXM3 pin 201/203 (e.g. camera sensor on carrier
+ * board)
  */
 &i2c3 {
 	clock-frequency = <100000>;
-- 
2.13.3
