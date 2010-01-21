From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Thu, 21 Jan 2010 12:12:52 +0300
Subject: [PATCH] ARM: MX3: Fixed typo in declared enum type name.
Message-ID: <1264065172-22494-1-git-send-email-vzapolskiy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To distinguish between mx31lite and mx31lilly boards better to use
different enum types.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
---
 arch/arm/plat-mxc/include/mach/board-mx31lite.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/board-mx31lite.h b/arch/arm/plat-mxc/include/mach/board-mx31lite.h
index 0184b63..2b2da03 100644
--- a/arch/arm/plat-mxc/include/mach/board-mx31lite.h
+++ b/arch/arm/plat-mxc/include/mach/board-mx31lite.h
@@ -25,7 +25,7 @@
 
 #ifndef __ASSEMBLY__
 
-enum mx31lilly_boards {
+enum mx31lite_boards {
 	MX31LITE_NOBOARD	= 0,
 	MX31LITE_DB		= 1,
 };
-- 
1.6.5.4
