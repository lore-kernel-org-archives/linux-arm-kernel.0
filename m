From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 16 Mar 2010 19:52:51 +0800
Subject: [PATCH 6/8] [ARM] pxa: remove unnecessary #include of <mach/ssp.h>
In-Reply-To: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
References: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1268740373-27407-7-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/littleton.c |    1 -
 arch/arm/mach-pxa/poodle.c    |    1 -
 arch/arm/mach-pxa/pxa3xx.c    |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index fa527b2..be727ae 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -41,7 +41,6 @@
 
 #include <mach/pxa300.h>
 #include <mach/pxafb.h>
-#include <mach/ssp.h>
 #include <mach/mmc.h>
 #include <mach/pxa2xx_spi.h>
 #include <mach/pxa27x_keypad.h>
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index d58a524..48b10c7 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -45,7 +45,6 @@
 #include <mach/poodle.h>
 #include <mach/pxafb.h>
 #include <mach/sharpsl.h>
-#include <mach/ssp.h>
 #include <mach/pxa2xx_spi.h>
 
 #include <asm/hardware/scoop.h>
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 4d7c03e..f544e58 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -29,7 +29,6 @@
 #include <mach/ohci.h>
 #include <mach/pm.h>
 #include <mach/dma.h>
-#include <mach/ssp.h>
 #include <mach/regs-intc.h>
 #include <plat/i2c.h>
 
-- 
1.6.3.3
