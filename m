From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 11 Feb 2016 16:47:36 -0600
Subject: [PATCH] ARM: socfpga_defconfig: enable support for initramfs/initrd
 support
Message-ID: <1455230856-19648-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Enable CONFIG_BLK_DEV_INITRD.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/configs/socfpga_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index f7f4e2e..753f1a5 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -7,6 +7,7 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
 CONFIG_CPUSETS=y
 CONFIG_NAMESPACES=y
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
@@ -107,4 +108,3 @@ CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_ENABLE_DEFAULT_TRACERS=y
 CONFIG_DEBUG_USER=y
-CONFIG_XZ_DEC=y
-- 
2.6.2
