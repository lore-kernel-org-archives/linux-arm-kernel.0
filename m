From: ludovic.Barre@st.com (Ludovic Barre)
Date: Fri, 7 Jul 2017 09:26:24 +0200
Subject: [PATCH 1/8] irqchip: stm32: select GENERIC_IRQ_CHIP
In-Reply-To: <1499412391-25480-1-git-send-email-ludovic.Barre@st.com>
References: <1499412391-25480-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1499412391-25480-2-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 676232a..202f77c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -298,6 +298,7 @@ config EZNPS_GIC
 config STM32_EXTI
 	bool
 	select IRQ_DOMAIN
+	select GENERIC_IRQ_CHIP
 
 config QCOM_IRQ_COMBINER
 	bool "QCOM IRQ combiner support"
-- 
2.7.4
