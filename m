From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 2 Sep 2016 17:33:12 +0200
Subject: [PATCH v3 3/9] ARM: STM32: Select external interrupts controller
In-Reply-To: <1472830398-13275-1-git-send-email-alexandre.torgue@st.com>
References: <1472830398-13275-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1472830398-13275-4-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2d601d7..157cea9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -877,6 +877,7 @@ config ARCH_STM32
 	select CLKSRC_STM32
 	select PINCTRL
 	select RESET_CONTROLLER
+	select STM32_EXTI
 	help
 	  Support for STMicroelectronics STM32 processors.
 
-- 
1.9.1
