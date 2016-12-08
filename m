From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Thu,  8 Dec 2016 09:26:02 +0100
Subject: [PATCH v5 4/5] ARM: dts: Add I2C1 support for STM32429 eval board
In-Reply-To: <1481185563-8735-1-git-send-email-cedric.madianga@gmail.com>
References: <1481185563-8735-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1481185563-8735-5-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index afb90bc..74e0045 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -141,3 +141,9 @@
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
