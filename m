From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 17 Jun 2016 16:18:02 +0100
Subject: [PATCH] arm64: defconfig: enable msm8996 pinctrl support
Message-ID: <1466176682-28183-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables pinctrl support required to boot msm8996/apq8096
boards.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fd2d74d..43733c3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -186,6 +186,7 @@ CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MSM8916=y
+CONFIG_PINCTRL_MSM8996=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_DWAPB=y
-- 
2.7.4
