From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 26 Sep 2012 05:47:19 +1200
Subject: [PATCH] arm: vt8500: Fixup for missing gpio.h
In-Reply-To: <1348595239-30577-1-git-send-email-linux@prisktech.co.nz>
References: <1348595239-30577-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1348595239-30577-2-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach/include/gpio.h was removed as part of the multiplatform-3.7
update. This patch removes the include from arch-vt8500/vt8500.c

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/mach-vt8500/vt8500.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
index 4494993..587ea95 100644
--- a/arch/arm/mach-vt8500/vt8500.c
+++ b/arch/arm/mach-vt8500/vt8500.c
@@ -32,7 +32,6 @@
 #include <linux/of_platform.h>
 
 #include <mach/restart.h>
-#include <mach/gpio.h>
 
 #include "common.h"
 
-- 
1.7.9.5
