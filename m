From: yannick.fertre@st.com (Yannick Fertre)
Date: Wed, 22 Mar 2017 16:04:42 +0100
Subject: [PATCH v3 4/5] ARM: dts: stm32: Add watchdog support for STM32F429
 eval board
In-Reply-To: <1490195083-25117-1-git-send-email-yannick.fertre@st.com>
References: <1490195083-25117-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1490195083-25117-5-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds watchdog support for STM32x9I-Eval board.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 3c99466..1c7d0b9 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -126,6 +126,10 @@
 	};
 };
 
+&iwdg {
+	status = "okay";
+};
+
 &adc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&adc3_in8_pin>;
-- 
1.9.1
