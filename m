From: nikai@nikai.net (Nicolas Kaiser)
Date: Mon, 4 Oct 2010 12:39:47 +0200
Subject: [PATCH 5/5] arm/davinci: remove duplicated include
In-Reply-To: <20101004122436.7092868f@absol.kitzblitz>
References: <20101004122436.7092868f@absol.kitzblitz>
Message-ID: <20101004123947.1e89128f@absol.kitzblitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated include.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 arch/arm/mach-davinci/board-da850-evm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index fdc2cc5..851cc45 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -26,7 +26,6 @@
 #include <linux/mtd/physmap.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/tps6507x.h>
-#include <linux/mfd/tps6507x.h>
 #include <linux/input/tps6507x-ts.h>
 
 #include <asm/mach-types.h>
-- 
1.7.2.2
