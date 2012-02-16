From: danny.kukawka@bisect.de (Danny Kukawka)
Date: Thu, 16 Feb 2012 15:44:31 +0100
Subject: [PATCH] arch/arm/mach-tegra/board-dt-tegra20.c: included
 asm/hardware/gic.h twice
Message-ID: <1329403471-32438-1-git-send-email-danny.kukawka@bisect.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-tegra/board-dt-tegra20.c: included 'asm/hardware/gic.h'
twice remove the duplicates.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/arm/mach-tegra/board-dt-tegra20.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index 7a95e0b..2a0351b 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -37,7 +37,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/setup.h>
-#include <asm/hardware/gic.h>
 
 #include <mach/iomap.h>
 #include <mach/irqs.h>
-- 
1.7.8.3
