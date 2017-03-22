From: yannick.fertre@st.com (Yannick Fertre)
Date: Wed, 22 Mar 2017 15:12:53 +0100
Subject: [PATCH v2 4/5] ARM: dts: stm32: Add watchdog support for STM32F429
 eval board
In-Reply-To: <1490191974-29722-1-git-send-email-yannick.fertre@st.com>
References: <1490191974-29722-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1490191974-29722-5-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds watchdog support for STM32x9I-Eval board.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 3c99466..aab81ed 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -181,3 +181,7 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&iwdg {
+	status = "okay";
+};
-- 
1.9.1
