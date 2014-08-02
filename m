From: libv@skynet.be (Luc Verhaegen)
Date: Sat,  2 Aug 2014 15:06:30 +0200
Subject: [PATCH] ARM: sunxi_defconfig: add NLS_CODEPAGE_437 and NLS_ISO8859_1
Message-ID: <1406984790-16994-1-git-send-email-libv@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise CONFIG_VFAT_FS is useless as mounting vfat fails.

Signed-off-by: Luc Verhaegen <libv@skynet.be>
---
 arch/arm/configs/sunxi_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 7209bfd..4532059 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -103,5 +103,7 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
-- 
1.7.7
