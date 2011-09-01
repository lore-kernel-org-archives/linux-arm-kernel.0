From: robherring2@gmail.com (Rob Herring)
Date: Wed, 31 Aug 2011 20:44:03 -0500
Subject: [PATCH v2 4/7] MAINTAINERS: add Calxeda Highbank ARM platform
In-Reply-To: <1314841446-11006-1-git-send-email-robherring2@gmail.com>
References: <1314841446-11006-1-git-send-email-robherring2@gmail.com>
Message-ID: <1314841446-11006-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Adding maintainer for arch/arm/mach-highbank/

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a8cc60..6c036ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -688,6 +688,12 @@ F:	drivers/mtd/nand/bcm_umi_nand.c
 F:	drivers/mtd/nand/bcm_umi_bch.c
 F:	drivers/mtd/nand/nand_bcm_umi.h
 
+ARM/CALXEDA HIGHBANK ARCHITECTURE
+M:	Rob Herring <rob.herring@calxeda.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-highbank/
+
 ARM/CAVIUM NETWORKS CNS3XXX MACHINE SUPPORT
 M:	Anton Vorontsov <avorontsov@mvista.com>
 S:	Maintained
-- 
1.7.4.1
