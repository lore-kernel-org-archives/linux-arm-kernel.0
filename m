From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Jun 2012 01:17:02 -0300
Subject: [PATCH] ARM: imx27_visstrim_m10: Do not include <asm/system.h>
Message-ID: <1340597822-19672-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

commit 435ca24 (ARM i.MX: Visstrim_M10: Add board version detection)
included <asm/system.h>, which is a header file about to be deleted according to 
9f97da (Disintegrate asm/system.h for ARM)

Include <asm/system_info.h> instead.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index f76edb9..ba09552 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -38,7 +38,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <asm/system.h>
+#include <asm/system_info.h>
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>
 
-- 
1.7.1
