From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 2 Sep 2016 17:33:16 +0200
Subject: [PATCH v3 7/9] ARM: dts: Add GPIO irq support to STM2F429
In-Reply-To: <1472830398-13275-1-git-send-email-alexandre.torgue@st.com>
References: <1472830398-13275-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1472830398-13275-8-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 1a189d4..6824762 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -189,6 +189,8 @@
 			#size-cells = <1>;
 			compatible = "st,stm32f429-pinctrl";
 			ranges = <0 0x40020000 0x3000>;
+			interrupt-parent = <&exti>;
+			st,syscfg = <&syscfg 0x8>;
 			pins-are-numbered;
 
 			gpioa: gpio at 40020000 {
-- 
1.9.1
