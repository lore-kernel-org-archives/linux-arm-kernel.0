From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 9 Apr 2013 14:45:00 +0200
Subject: [PATCH] mmc: atmel-mci: remove include <mach/cpu.h>
Message-ID: <1365511500-13778-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Header file not needed anymore as we have removed
the calls to cpu_is_xxx() macro.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mmc/host/atmel-mci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index e75774f..08e2b92 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -40,8 +40,6 @@
 #include <asm/io.h>
 #include <asm/unaligned.h>
 
-#include <mach/cpu.h>
-
 #include "atmel-mci-regs.h"
 
 #define ATMCI_DATA_ERROR_FLAGS	(ATMCI_DCRCE | ATMCI_DTOE | ATMCI_OVRE | ATMCI_UNRE)
-- 
1.8.0
