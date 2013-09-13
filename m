From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Sep 2013 12:51:35 +0200
Subject: [PATCH 2/6] MAINTAINERS: delete Shark machine entry
Message-ID: <1379069495-4055-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reflects the fact that the Shark machine has been deleted
as an ARM sub-architecture.

Cc: arm at kernel.org
Cc: Alexander Schulz <alex@shark-linux.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 MAINTAINERS | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e61c2e8..b95ebad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1142,11 +1142,6 @@ F:	drivers/net/ethernet/i825xx/ether1*
 F:	drivers/net/ethernet/seeq/ether3*
 F:	drivers/scsi/arm/
 
-ARM/SHARK MACHINE SUPPORT
-M:	Alexander Schulz <alex@shark-linux.de>
-W:	http://www.shark-linux.de/shark.html
-S:	Maintained
-
 ARM/SAMSUNG ARM ARCHITECTURES
 M:	Ben Dooks <ben-linux@fluff.org>
 M:	Kukjin Kim <kgene.kim@samsung.com>
-- 
1.8.3.1
