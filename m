From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Fri, 10 Oct 2014 17:08:22 +0300
Subject: [PATCH] ARM: multi_v7_defconfig: Enable clocks for APQ8084 boards
Message-ID: <1412950102-10049-1-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the clocks for the Qualcomm APQ8084 platforms to allow
booting with multi_v7_defconfig.

Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
---
 arch/arm/configs/multi_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5fcdb791fa74..13aeef394603 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -411,6 +411,8 @@ CONFIG_NVEC_POWER=y
 CONFIG_NVEC_PAZ00=y
 CONFIG_QCOM_GSBI=y
 CONFIG_COMMON_CLK_QCOM=y
+CONFIG_APQ_GCC_8084=y
+CONFIG_APQ_MMCC_8084=y
 CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
-- 
1.7.9.5
