From: nikai@nikai.net (Nicolas Kaiser)
Date: Mon, 4 Oct 2010 12:39:29 +0200
Subject: [PATCH 3/5] arm/shmobile: remove duplicated include
In-Reply-To: <20101004122436.7092868f@absol.kitzblitz>
References: <20101004122436.7092868f@absol.kitzblitz>
Message-ID: <20101004123929.094848ba@absol.kitzblitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated include.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 95935c8..3ebb5be 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -30,7 +30,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
-#include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/i2c.h>
 #include <linux/i2c/tsc2007.h>
-- 
1.7.2.2
