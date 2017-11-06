From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 6 Nov 2017 18:03:31 +0100
Subject: [PATCH v3 1/9] irqchip: stm32: select GENERIC_IRQ_CHIP
In-Reply-To: <1509987819-29599-1-git-send-email-ludovic.Barre@st.com>
References: <1509987819-29599-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1509987819-29599-2-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds GENERIC_IRQ_CHIP to stm32 exti
config.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 9d8a1dd..c067aae 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -304,6 +304,7 @@ config EZNPS_GIC
 config STM32_EXTI
 	bool
 	select IRQ_DOMAIN
+	select GENERIC_IRQ_CHIP
 
 config QCOM_IRQ_COMBINER
 	bool "QCOM IRQ combiner support"
-- 
2.7.4
