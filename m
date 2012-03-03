From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat,  3 Mar 2012 07:47:25 +0100
Subject: [PATCH 1/1] mtd: ofpart Kconfig fix typo
Message-ID: <1330757245-8691-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

it's "default y" not "default Y"

The typo was introduced in 3.1 by
Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
since commit
d6137badeff1ef64b4e0092ec249ebdeaeb3ff37

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: stable at vger.kernel.org
---
 drivers/mtd/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 1be6218..5e78236 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -128,7 +128,7 @@ config MTD_AFS_PARTS
 
 config MTD_OF_PARTS
 	tristate "OpenFirmware partitioning information support"
-	default Y
+	default y
 	depends on OF
 	help
 	  This provides a partition parsing function which derives
-- 
1.7.7
