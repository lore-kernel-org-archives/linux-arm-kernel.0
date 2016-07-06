From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  6 Jul 2016 09:54:26 +0100
Subject: [PATCH v6 08/18] ARM: multi_v7_defconfig: Enable STi FDMA driver
In-Reply-To: <1467795276-21725-1-git-send-email-peter.griffin@linaro.org>
References: <1467795276-21725-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1467795276-21725-9-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This DMA controller is found on all STi chipsets.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 3ac30f0..541c914 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -747,6 +747,7 @@ CONFIG_DMA_OMAP=y
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_XILINX_VDMA=y
 CONFIG_DMA_SUN6I=y
+CONFIG_ST_FDMA=m
 CONFIG_STAGING=y
 CONFIG_SENSORS_ISL29018=y
 CONFIG_SENSORS_ISL29028=y
-- 
1.9.1
