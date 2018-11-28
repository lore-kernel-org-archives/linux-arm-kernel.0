From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 28 Nov 2018 12:04:03 +0900
Subject: [PATCH] ARM: multi_v7_defconfig: enable CONFIG_UNIPHIER_MDMAC
Message-ID: <1543374243-29475-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the UniPhier MIO DMAC driver. This is used as the DMA engine
for accelerating the SD/eMMC controller drivers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

The insertion context was decided by savedefconfig on next-20181127.


 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 63af623..715da88 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -862,6 +862,7 @@ CONFIG_STM32_DMA=y
 CONFIG_STM32_DMAMUX=y
 CONFIG_STM32_MDMA=y
 CONFIG_TEGRA20_APB_DMA=y
+CONFIG_UNIPHIER_MDMAC=y
 CONFIG_XILINX_DMA=y
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_DW_DMAC=y
-- 
2.7.4
