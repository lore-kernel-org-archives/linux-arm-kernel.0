From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 26 Jun 2018 18:19:00 +0200
Subject: [PATCH 1/2] ARM: dts: stm32: remove gpio aliases for stm32mp157c
In-Reply-To: <1530029941-26089-1-git-send-email-alexandre.torgue@st.com>
References: <1530029941-26089-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1530029941-26089-2-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO aliases are not used by stm32 pinctrl driver.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 5183830..9dc4ff0 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -35,20 +35,6 @@
 		cpu_on = <0x84000003>;
 	};
 
-	aliases {
-		gpio0 = &gpioa;
-		gpio1 = &gpiob;
-		gpio2 = &gpioc;
-		gpio3 = &gpiod;
-		gpio4 = &gpioe;
-		gpio5 = &gpiof;
-		gpio6 = &gpiog;
-		gpio7 = &gpioh;
-		gpio8 = &gpioi;
-		gpio9 = &gpioj;
-		gpio10 = &gpiok;
-	};
-
 	intc: interrupt-controller at a0021000 {
 		compatible = "arm,cortex-a7-gic";
 		#interrupt-cells = <3>;
-- 
2.7.4
