From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 21 Oct 2014 19:55:20 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: fix support for APQ8084
Message-ID: <1413917720-17069-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables configs required to boot IFC6540 board with atleast a
serial console.

Without this patch there is no serial console.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 491b7d5..c329338 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -235,6 +235,7 @@ CONFIG_SPI_TEGRA20_SLINK=y
 CONFIG_SPI_XILINX=y
 CONFIG_PINCTRL_AS3722=y
 CONFIG_PINCTRL_PALMAS=y
+CONFIG_PINCTRL_APQ8084=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
 CONFIG_GPIO_DWAPB=y
@@ -409,6 +410,7 @@ CONFIG_NVEC_POWER=y
 CONFIG_NVEC_PAZ00=y
 CONFIG_QCOM_GSBI=y
 CONFIG_COMMON_CLK_QCOM=y
+CONFIG_APQ_MMCC_8084=y
 CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
-- 
1.9.1
