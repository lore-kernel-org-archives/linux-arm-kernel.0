From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 12 Oct 2010 18:23:15 +0100
Subject: [PATCH 2/2] S3C64XX: Ensure s3c64xx_ide_setup_gpio() is prototyped
In-Reply-To: <1286904195-1534-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1286904195-1534-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1286904195-1534-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since it's exported we should make sure we're using the prototype
others see.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/setup-ide.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/setup-ide.c b/arch/arm/mach-s3c64xx/setup-ide.c
index de645e9..41b4256 100644
--- a/arch/arm/mach-s3c64xx/setup-ide.c
+++ b/arch/arm/mach-s3c64xx/setup-ide.c
@@ -17,6 +17,7 @@
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 #include <plat/gpio-cfg.h>
+#include <plat/ata.h>
 
 void s3c64xx_ide_setup_gpio(void)
 {
-- 
1.7.1
