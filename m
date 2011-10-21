From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 21 Oct 2011 19:59:32 +0200
Subject: [PATCH] ARM i.MX avic: add missing include
Message-ID: <mailman.195.1319220128.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/avic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index 8875fb4..ff31c22 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -23,6 +23,7 @@
 #include <mach/common.h>
 #include <asm/mach/irq.h>
 #include <mach/hardware.h>
+#include <asm/exception.h>
 
 #include "irq-common.h"
 
-- 
1.7.7

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
