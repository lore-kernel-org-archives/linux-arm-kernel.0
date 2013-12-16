From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Dec 2013 12:26:25 -0800
Subject: [PATCH] ARM: ux500: turn on PRINTK_TIME in u8500_defconfig
Message-ID: <1387225585-14107-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I recently noticed slow booting of a board, and without printk timestamps it's
harder to tell just where the delays are coming from. Enable it.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/configs/u8500_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index c6ebc18..65f7788 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -119,6 +119,7 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
-- 
1.7.10.4
