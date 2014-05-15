From: elder@linaro.org (Alex Elder)
Date: Thu, 15 May 2014 12:58:09 -0500
Subject: [PATCH v3 RESEND 3/5] ARM: configs: enable SMP in bcm_defconfig
In-Reply-To: <1400176691-26058-1-git-send-email-elder@linaro.org>
References: <1400176691-26058-1-git-send-email-elder@linaro.org>
Message-ID: <1400176691-26058-4-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also explicitly set CONFIG_NR_CPUS to 2, limiting it to the most we
currently need.

Signed-off-by: Ray Jui <rjui@broadcom.com>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm/configs/bcm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index 3df3f3a..626f077 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -24,6 +24,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
+CONFIG_SMP=y
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM_MOBILE=y
 CONFIG_ARM_THUMBEE=y
-- 
1.9.1
