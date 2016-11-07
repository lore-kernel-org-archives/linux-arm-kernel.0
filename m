From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon,  7 Nov 2016 18:17:41 +0000
Subject: [PATCH v11 10/14] ARM: multi_v7_defconfig: Enable STi FDMA driver
In-Reply-To: <1478542665-17089-1-git-send-email-peter.griffin@linaro.org>
References: <1478542665-17089-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1478542665-17089-11-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This DMA controller is found on all STi chipsets.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 0a06af9..ce9ab5a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -790,6 +790,7 @@ CONFIG_DMA_OMAP=y
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_XILINX_DMA=y
 CONFIG_DMA_SUN6I=y
+CONFIG_ST_FDMA=m
 CONFIG_STAGING=y
 CONFIG_SENSORS_ISL29018=y
 CONFIG_SENSORS_ISL29028=y
-- 
2.7.4
