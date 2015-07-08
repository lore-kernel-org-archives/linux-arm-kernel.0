From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  8 Jul 2015 17:11:28 +0100
Subject: [PATCH 7/7] ARM: multi_v7_defconfig: Enable STi FDMA driver
In-Reply-To: <1436371888-27863-1-git-send-email-peter.griffin@linaro.org>
References: <1436371888-27863-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1436371888-27863-8-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This DMA controller is found on all STi chipsets.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6d83a1b..370dd85 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -588,6 +588,8 @@ CONFIG_IMX_DMA=y
 CONFIG_MXS_DMA=y
 CONFIG_DMA_OMAP=y
 CONFIG_XILINX_VDMA=y
+CONFIG_ST_FDMA=y
+CONFIG_ST_FDMA_XBAR=y
 CONFIG_STAGING=y
 CONFIG_SENSORS_ISL29018=y
 CONFIG_SENSORS_ISL29028=y
-- 
1.9.1
