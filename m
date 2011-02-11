From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Fri, 11 Feb 2011 12:28:18 -0800
Subject: [PATCH 3/3] msm: iommu: Enable IOMMU support for MSM8960
In-Reply-To: <1297456098-3241-1-git-send-email-stepanm@codeaurora.org>
References: <1297456098-3241-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <1297456098-3241-3-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow IOMMU to be selected for MSM8960 now that the
platform data has been generalized.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 32b9d1f..997c5bd 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -150,7 +150,7 @@ endmenu

 config MSM_IOMMU
 	bool "MSM IOMMU Support"
-	depends on ARCH_MSM8X60
+	depends on ARCH_MSM8X60 || ARCH_MSM8960
 	select IOMMU_API
 	default n
 	help
--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
