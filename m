From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Nov 2012 12:22:50 +0100
Subject: [PATCH 06/10] arm: at91: move board header to arch/arm/mach-at91
In-Reply-To: <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121107111235.GH20063@game.jcrosoft.org>
 <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1352287374-25176-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/board-gsia18s.c                |    4 ++--
 arch/arm/mach-at91/board-pcontrol-g20.c           |    2 +-
 arch/arm/mach-at91/{include/mach => }/gsia18s.h   |    0
 arch/arm/mach-at91/{include/mach => }/stamp9g20.h |    0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/arm/mach-at91/{include/mach => }/gsia18s.h (100%)
 rename arch/arm/mach-at91/{include/mach => }/stamp9g20.h (100%)

diff --git a/arch/arm/mach-at91/board-gsia18s.c b/arch/arm/mach-at91/board-gsia18s.c
index 842add7..23a2fa1 100644
--- a/arch/arm/mach-at91/board-gsia18s.c
+++ b/arch/arm/mach-at91/board-gsia18s.c
@@ -31,13 +31,13 @@
 #include <asm/mach/arch.h>
 
 #include <mach/at91sam9_smc.h>
-#include <mach/gsia18s.h>
-#include <mach/stamp9g20.h>
 
 #include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
+#include "gsia18s.h"
+#include "stamp9g20.h"
 
 static void __init gsia18s_init_early(void)
 {
diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
index 977fa78..0299554 100644
--- a/arch/arm/mach-at91/board-pcontrol-g20.c
+++ b/arch/arm/mach-at91/board-pcontrol-g20.c
@@ -30,12 +30,12 @@
 #include <asm/mach/arch.h>
 
 #include <mach/at91sam9_smc.h>
-#include <mach/stamp9g20.h>
 
 #include "at91_aic.h"
 #include "board.h"
 #include "sam9_smc.h"
 #include "generic.h"
+#include "stamp9g20.h"
 
 
 static void __init pcontrol_g20_init_early(void)
diff --git a/arch/arm/mach-at91/include/mach/gsia18s.h b/arch/arm/mach-at91/gsia18s.h
similarity index 100%
rename from arch/arm/mach-at91/include/mach/gsia18s.h
rename to arch/arm/mach-at91/gsia18s.h
diff --git a/arch/arm/mach-at91/include/mach/stamp9g20.h b/arch/arm/mach-at91/stamp9g20.h
similarity index 100%
rename from arch/arm/mach-at91/include/mach/stamp9g20.h
rename to arch/arm/mach-at91/stamp9g20.h
-- 
1.7.10.4
