From: marex@denx.de (Marek Vasut)
Date: Wed, 19 Dec 2012 18:33:02 +0100
Subject: [PATCH 4/8] arm: mxs: Enable JFFS2
In-Reply-To: <1355938386-14582-1-git-send-email-marex@denx.de>
References: <1355938386-14582-1-git-send-email-marex@denx.de>
Message-ID: <1355938386-14582-5-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The JFFS2 is very commonly used on NOR flashes. Enable it.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/configs/mxs_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 69efd38..41b5a74 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -139,6 +139,10 @@ CONFIG_FSCACHE_STATS=y
 CONFIG_CACHEFILES=m
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_LZO=y
+CONFIG_JFFS2_RUBIN=y
 CONFIG_UBIFS_FS=y
 CONFIG_UBIFS_FS_ADVANCED_COMPR=y
 CONFIG_NFS_FS=y
-- 
1.7.10.4
