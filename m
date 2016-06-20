From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Mon, 20 Jun 2016 18:22:50 +0200
Subject: [PATCH v3 4/5] ARM: dts: Add I2C1 support for STM32429 eval board
In-Reply-To: <1466439771-2741-1-git-send-email-cedric.madianga@gmail.com>
References: <1466439771-2741-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1466439771-2741-5-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 6bfc595..e95657f 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -123,3 +123,9 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins_b>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
1.9.1
