From: robherring2@gmail.com (Rob Herring)
Date: Thu,  6 Sep 2012 15:12:53 -0500
Subject: [PATCH 10/12] ARM: mvebu: move armada-370-xp.h in mach dir
In-Reply-To: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346962375-26163-11-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-mvebu/armada-370-xp.c                |    2 +-
 .../mach-mvebu/{include/mach => }/armada-370-xp.h  |    0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/mach-mvebu/{include/mach => }/armada-370-xp.h (100%)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 4ef923b..b46418a 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -20,7 +20,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <mach/armada-370-xp.h>
+#include "armada-370-xp.h"
 #include "common.h"
 
 static struct map_desc armada_370_xp_io_desc[] __initdata = {
diff --git a/arch/arm/mach-mvebu/include/mach/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
similarity index 100%
rename from arch/arm/mach-mvebu/include/mach/armada-370-xp.h
rename to arch/arm/mach-mvebu/armada-370-xp.h
-- 
1.7.9.5
