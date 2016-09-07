From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  7 Sep 2016 10:18:42 +0200
Subject: [PATCH] ARM: qcom_defconfig: Fix MDM9515 LCC and GCC config
Message-ID: <1473236322-16865-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct prefix is MDM instead of MSM.

Fixes: 8aa788d3e59a ("ARM: configs: qualcomm: Add MDM9615 missing defconfigs")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/configs/qcom_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index c2dff4f..9f6d2a6 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -162,8 +162,8 @@ CONFIG_APQ_MMCC_8084=y
 CONFIG_IPQ_LCC_806X=y
 CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_LCC_8960=y
-CONFIG_MSM_GCC_9615=y
-CONFIG_MSM_LCC_9615=y
+CONFIG_MDM_GCC_9615=y
+CONFIG_MDM_LCC_9615=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
 CONFIG_HWSPINLOCK_QCOM=y
-- 
1.9.1
