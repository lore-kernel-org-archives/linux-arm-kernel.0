From: sbranden@broadcom.com (Scott Branden)
Date: Tue, 28 Oct 2014 12:53:12 -0700
Subject: [PATCH v8 8/8] ARM: multi_v7_defconfig: Enable Broadcom Cygnus
In-Reply-To: <1414525992-3678-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1414525992-3678-1-git-send-email-sbranden@broadcom.com>
Message-ID: <1414525992-3678-9-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ray Jui <rjui@broadcom.com>

Enable Broadcom Cygnus platform support in multi_v7_defconfig

Signed-off-by: Ray Jui <rjui@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/configs/multi_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6e0d7cb..c223da3 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -17,6 +17,7 @@ CONFIG_MACH_ARMADA_38X=y
 CONFIG_MACH_ARMADA_XP=y
 CONFIG_MACH_DOVE=y
 CONFIG_ARCH_BCM=y
+CONFIG_ARCH_BCM_CYGNUS=y
 CONFIG_ARCH_BCM_21664=y
 CONFIG_ARCH_BCM_281XX=y
 CONFIG_ARCH_BCM_5301X=y
-- 
1.7.9.5
