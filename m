From: varada@codeaurora.org (Varadarajan Narayanan)
Date: Thu,  1 Jun 2017 16:58:02 +0530
Subject: [PATCH v3 5/5] arm64: defconfig: Enable QCOM IPQ8074 clock and pinctrl
In-Reply-To: <1496316482-25468-1-git-send-email-varada@codeaurora.org>
References: <1496316482-25468-1-git-send-email-varada@codeaurora.org>
Message-ID: <1496316482-25468-6-git-send-email-varada@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhishek Sahu <absahu@codeaurora.org>

These configs are required for booting kernel in QCOM
IPQ8074 boards.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 65cdd87..c20328e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -267,6 +267,7 @@ CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
+CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_MAX77620=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_MSM8994=y
@@ -450,6 +451,7 @@ CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_PWM=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_CLK_SMD_RPM=y
+CONFIG_IPQ_GCC_8074=y
 CONFIG_MSM_GCC_8916=y
 CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_MMCC_8996=y
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
