From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Mon, 13 Mar 2017 15:16:01 +0100
Subject: [PATCH 5/5] ARM: configs: stm32: Add DMAMUX support in STM32 defconfig
In-Reply-To: <1489414561-28912-1-git-send-email-cedric.madianga@gmail.com>
References: <1489414561-28912-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <1489414561-28912-6-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMAMUX support in STM32 defconfig file

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 arch/arm/configs/stm32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index a9d8e3c..afb6832 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -60,6 +60,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_STM32=y
 CONFIG_DMADEVICES=y
 CONFIG_STM32_DMA=y
+CONFIG_STM32_DMAMUX=y
 CONFIG_IIO=y
 CONFIG_STM32_ADC_CORE=y
 CONFIG_STM32_ADC=y
-- 
1.9.1
