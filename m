From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu,  9 Apr 2015 13:20:42 -0600
Subject: [PATCH v19 2/3] ARM: config: Update qcom_defconfig to enable cpuidle
In-Reply-To: <1428607243-7723-1-git-send-email-lina.iyer@linaro.org>
References: <1428607243-7723-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1428607243-7723-3-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update qcom_defconfig to allow cpuidle for QCOM cpus.

* Enable QCOM_PM
* Enable ARM_CPUIDLE

Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 8c7da33..33a5339 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -30,6 +30,7 @@ CONFIG_CLEANCACHE=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
@@ -135,6 +136,7 @@ CONFIG_DMADEVICES=y
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_STAGING=y
 CONFIG_QCOM_GSBI=y
+CONFIG_QCOM_PM=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_APQ_MMCC_8084=y
 CONFIG_IPQ_GCC_806X=y
-- 
2.1.0
