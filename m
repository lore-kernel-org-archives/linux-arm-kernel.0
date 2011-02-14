From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 14 Feb 2011 17:23:05 +0900
Subject: [PATCH 09/11] mtd: OneNAND: Change dependency of ARCH_EXYNOS4
In-Reply-To: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
References: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1297671787-10571-10-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates EXYNOS4 OneNAND support according to the change of
ARCH name, EXYNOS4.

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/mtd/onenand/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/onenand/Kconfig b/drivers/mtd/onenand/Kconfig
index 4dbd0f5..4f42619 100644
--- a/drivers/mtd/onenand/Kconfig
+++ b/drivers/mtd/onenand/Kconfig
@@ -32,7 +32,7 @@ config MTD_ONENAND_OMAP2
 
 config MTD_ONENAND_SAMSUNG
         tristate "OneNAND on Samsung SOC controller support"
-        depends on ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5PV310
+        depends on ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS4
         help
           Support for a OneNAND flash device connected to an Samsung SOC.
           S3C64XX/S5PC100 use command mapping method.
-- 
1.7.1
