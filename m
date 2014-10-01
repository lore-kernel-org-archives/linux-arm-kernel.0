From: joshc@codeaurora.org (Josh Cartwright)
Date: Wed,  1 Oct 2014 12:03:14 -0500
Subject: [PATCH 1/4] ARM: qcom: add QCOM_WDT driver to qcom_defconfig
In-Reply-To: <cover.1412182773.git.joshc@codeaurora.org>
References: <cover.1412182773.git.joshc@codeaurora.org>
Message-ID: <b413be77d323a6ec82e5d3ceef1bf038e24d0e8a.1412182773.git.joshc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select QCOM_WDT to allow for the watchdog driver to be built.

Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
---
 arch/arm/configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 8c7da33..80bad9a 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -103,6 +103,8 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_QCOM_WDT=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_MEDIA_SUPPORT=y
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
