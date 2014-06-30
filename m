From: ohaugan@codeaurora.org (Olav Haugan)
Date: Mon, 30 Jun 2014 09:51:55 -0700
Subject: [RFC/PATCH 6/7] defconfig: msm: Enable Qualcomm SMMUv1 driver
In-Reply-To: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
Message-ID: <1404147116-4598-7-git-send-email-ohaugan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Qualcomm SMMUv1 driver allowing bus masters to operate
on physically discontigous memory.

Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 0414889..12838bb 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -137,6 +137,7 @@ CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
 CONFIG_MSM_IOMMU_V0=y
+CONFIG_MSM_IOMMU_V1=y
 CONFIG_GENERIC_PHY=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
