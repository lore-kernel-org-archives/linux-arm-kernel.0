From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 28 Jun 2011 14:49:15 +0200
Subject: [PATCH 3/5] mach-gta2: remove unused spi-gpio.h include
In-Reply-To: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
References: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <1309265357-15879-4-git-send-email-jacmet@sunsite.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not needed, and the file is going away.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/arm/mach-s3c2440/mach-gta02.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 7166620..c10ddf4 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -74,7 +74,6 @@
 #include <mach/fb.h>
 
 #include <mach/spi.h>
-#include <mach/spi-gpio.h>
 #include <plat/usb-control.h>
 #include <mach/regs-mem.h>
 #include <mach/hardware.h>
-- 
1.7.5.4
