From: peter.griffin@linaro.org (Peter Griffin)
Date: Sat,  8 Oct 2016 13:52:32 +0100
Subject: [PATCH v10 10/11] ARM: multi_v7_defconfig: Enable STi FDMA driver
In-Reply-To: <1475931154-1021-1-git-send-email-peter.griffin@linaro.org>
References: <1475931154-1021-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1475931154-1021-11-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This DMA controller is found on all STi chipsets.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 33f7a8a..46f174e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -784,6 +784,7 @@ CONFIG_DMA_OMAP=y
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_XILINX_DMA=y
 CONFIG_DMA_SUN6I=y
+CONFIG_ST_FDMA=m
 CONFIG_STAGING=y
 CONFIG_SENSORS_ISL29018=y
 CONFIG_SENSORS_ISL29028=y
-- 
1.9.1
