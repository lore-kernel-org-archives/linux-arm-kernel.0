From: jaswinder@kernel.org (Jaswinder Singh Rajput)
Date: Tue, 22 Sep 2009 18:37:01 +0530
Subject: [PATCH] ARM: includecheck fix: mach-davinci, board-dm365-evm.c
Message-ID: <1253624821.3784.8.camel@ht.satnam>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


fix the following 'make includecheck' warning:

  arch/arm/mach-davinci/board-dm365-evm.c: mach/common.h is included more than once.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index a1d5e7d..52dd804 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -35,7 +35,6 @@
 #include <mach/common.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
-#include <mach/common.h>
 #include <mach/mmc.h>
 #include <mach/nand.h>
 
-- 
1.6.0.6
