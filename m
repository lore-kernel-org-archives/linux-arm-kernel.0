From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 17 Dec 2009 21:20:15 -0700
Subject: [PATCH 1/8] OMAP2: remove duplicated #include
In-Reply-To: <20091218041912.27280.92152.stgit@localhost.localdomain>
References: <20091218041912.27280.92152.stgit@localhost.localdomain>
Message-ID: <20091218042014.27280.91017.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Huang Weiyi <weiyi.huang@gmail.com>

Remove duplicated #include('s) in
  arch/arm/mach-omap2/clock34xx.c
  arch/arm/mach-omap2/io.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.c |    1 -
 arch/arm/mach-omap2/io.c        |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index ded3236..d4217b9 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -34,7 +34,6 @@
 #include <asm/div64.h>
 #include <asm/clkdev.h>
 
-#include <plat/sdrc.h>
 #include "clock.h"
 #include "clock34xx.h"
 #include "sdrc.h"
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index a8749e8..ac9ea60 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -33,7 +33,6 @@
 #include <plat/sdrc.h>
 #include <plat/gpmc.h>
 #include <plat/serial.h>
-#include <plat/mux.h>
 #include <plat/vram.h>
 
 #include "clock.h"
