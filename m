From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Thu, 6 Jul 2017 14:20:23 +0200
Subject: [PATCH v3 5/5] ARM: configs: stm32: Add DMAMUX support in STM32
 defconfig
In-Reply-To: <1499343623-5964-1-git-send-email-pierre-yves.mordret@st.com>
References: <1499343623-5964-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <1499343623-5964-6-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMAMUX support in STM32 defconfig file

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 Version history:
    v3:
    v2:
        * None
---
---
 arch/arm/configs/stm32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index a097538..15fbaba 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -64,6 +64,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_STM32=y
 CONFIG_DMADEVICES=y
 CONFIG_STM32_DMA=y
+CONFIG_STM32_DMAMUX=y
 CONFIG_IIO=y
 CONFIG_STM32_ADC_CORE=y
 CONFIG_STM32_ADC=y
-- 
2.7.4
