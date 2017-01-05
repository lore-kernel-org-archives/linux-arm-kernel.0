From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Thu,  5 Jan 2017 10:07:25 +0100
Subject: [PATCH v8 4/5] ARM: dts: stm32: Add I2C1 support for STM32429 eval
 board
In-Reply-To: <1483607246-14771-1-git-send-email-cedric.madianga@gmail.com>
References: <1483607246-14771-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1483607246-14771-5-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds I2C1 instance support for STM32x9I-Eval board.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 76f7206..c943539 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -146,3 +146,9 @@
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
