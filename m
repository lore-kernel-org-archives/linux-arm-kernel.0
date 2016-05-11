From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Wed, 11 May 2016 17:36:13 +0200
Subject: [PATCH 4/5] ARM: dts: Add I2C1 support for STM32429 eval board
In-Reply-To: <1462980974-22091-1-git-send-email-cedric.madianga@gmail.com>
References: <1462980974-22091-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1462980974-22091-5-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 6bfc595..0bf427a 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -123,3 +123,9 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&i2c1 {
+	pinctrl-0 = <&i2c1_sda_pin>, <&i2c1_scl_pin>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
1.9.1
