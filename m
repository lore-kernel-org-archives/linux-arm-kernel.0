From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Dec 2012 15:34:00 +0100
Subject: [PATCH 15/18] arm: kirkwood: dockstar: remove useless include of SDIO
 header
In-Reply-To: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1355841243-3254-16-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dockstar platform does not register any SDIO controller, therefore
it does not need to include the mmc-mvsdio.h header.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-kirkwood/dockstar-setup.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-kirkwood/dockstar-setup.c b/arch/arm/mach-kirkwood/dockstar-setup.c
index 791a98f..272af69 100644
--- a/arch/arm/mach-kirkwood/dockstar-setup.c
+++ b/arch/arm/mach-kirkwood/dockstar-setup.c
@@ -19,7 +19,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include <linux/platform_data/mmc-mvsdio.h>
 #include "common.h"
 #include "mpp.h"
 
-- 
1.7.9.5
