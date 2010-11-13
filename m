From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Fri, 12 Nov 2010 19:29:57 -0800
Subject: [PATCH 11/14] msm: iommu: Kconfig dependency for the IOMMU API
In-Reply-To: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
References: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <1289619000-13167-12-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the IOMMU driver select the IOMMU API in the kernel
configuration.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 7781920..2f7ca4c 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -44,6 +44,7 @@ config ARCH_MSM8X60
 	select CPU_V7
 	select MSM_V2_TLMM
 	select MSM_GPIOMUX
+	select IOMMU_API
 
 endchoice
 
@@ -177,4 +178,7 @@ config MSM_GPIOMUX
 
 config MSM_V2_TLMM
 	bool
+
+config IOMMU_API
+	bool
 endif
-- 
1.7.0.2

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
