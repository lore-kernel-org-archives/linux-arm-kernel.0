From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Apr 2016 15:21:33 +0200
Subject: [PATCH 3/4] ARM: tegra: irq: Add missing irq.h include
In-Reply-To: <1461849694-13068-1-git-send-email-thierry.reding@gmail.com>
References: <1461849694-13068-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1461849694-13068-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Some of the functions implemented are flagged as not having a prototype
defined when building with W=1. Include the header to avoid these build
warnings.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-tegra/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 3b9098d27ea5..a69b22d37eed 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -29,6 +29,7 @@
 
 #include "board.h"
 #include "iomap.h"
+#include "irq.h"
 
 #define SGI_MASK 0xFFFF
 
-- 
2.8.0
