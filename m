From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Mon, 9 Jan 2017 19:50:46 +0800
Subject: [RFC PATCH] arm64: defconfig: enable SMMUv3 config
Message-ID: <1483962646-33767-1-git-send-email-wangzhou1@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 869dded..3520c50 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -440,6 +440,7 @@ CONFIG_PLATFORM_MHU=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_HI6220_MBOX=y
 CONFIG_ARM_SMMU=y
+CONFIG_ARM_SMMU_V3=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD=y
-- 
1.9.1
