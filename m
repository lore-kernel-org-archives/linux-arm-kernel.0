From: anthony.harivel@gmail.com (Anthony Harivel)
Date: Thu,  5 Feb 2015 22:59:36 +0100
Subject: [PATCH] ARM: at91/defconfig: remove CONFIG_SYSFS_DEPRECATED
Message-ID: <1423173576-10888-1-git-send-email-anthony.harivel@emtrion.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent distributions and userspace tools after 2009/2010 depend on
the existence of /sys/class/block/, and will not work with this option enabled.

Signed-off-by: Anthony Harivel <anthony.harivel@emtrion.de>
---
 arch/arm/configs/sama5_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index c9089c9..59b48563 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -3,8 +3,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
-- 
1.9.1
