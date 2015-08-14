From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 14 Aug 2015 19:04:28 +0200
Subject: [PATCH] arm: lpda270_defconfig: disable IDE subsystem
In-Reply-To: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
References: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1439571876-13758-13-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch disables deprecated IDE subsystem in lpd270_defconfig
(no IDE host drivers are selected in this config so there is no
valid reason to enable IDE subsystem itself).

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/configs/lpd270_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/lpd270_defconfig b/arch/arm/configs/lpd270_defconfig
index 1c8c9ee..a9dd1e9 100644
--- a/arch/arm/configs/lpd270_defconfig
+++ b/arch/arm/configs/lpd270_defconfig
@@ -31,7 +31,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
 # CONFIG_MTD_CFI_I1 is not set
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_BLK_DEV_NBD=y
-CONFIG_IDE=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
-- 
1.9.1
