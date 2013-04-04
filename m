From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Apr 2013 12:29:47 +0900
Subject: [RFC/PATCH 1/7] ARM: shmobile: prune defconfig
In-Reply-To: <1365046193-19369-1-git-send-email-horms+renesas@verge.net.au>
References: <1365046193-19369-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1365046193-19369-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove a number of lines from the shmobile defconfig as they seem to
be orthogonal to shmobile, not necessary for booting boards,
and as far as I know not present in a number of the shmobile
board defconfigs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig |   12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 0f2d80d..90f5600 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -3,15 +3,9 @@ CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
@@ -145,9 +139,3 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_ARM_UNWIND is not set
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_DES=y
-CONFIG_CRYPTO_ANSI_CPRNG=y
-CONFIG_XZ_DEC=y
-- 
1.7.10.4
