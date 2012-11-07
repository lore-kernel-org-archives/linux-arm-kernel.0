From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 7 Nov 2012 20:53:49 +0800
Subject: [PATCH -next] ARM: OMAP2+: remove duplicated include from
 board-overo.c
Message-ID: <CAPgLHd9ZWdBzaM15ZBckZUGwSq-xcMncFayUrLtWjs0V+QYeqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/board-overo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 1cfb037..f5ba43f 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -45,7 +45,6 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
-#include "common.h"
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
 #include <video/omap-panel-tfp410.h>
