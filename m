From: nikai@nikai.net (Nicolas Kaiser)
Date: Mon, 4 Oct 2010 12:39:18 +0200
Subject: [PATCH 2/5] arm/tegra: remove duplicated include
In-Reply-To: <20101004122436.7092868f@absol.kitzblitz>
References: <20101004122436.7092868f@absol.kitzblitz>
Message-ID: <20101004123918.383b2b0a@absol.kitzblitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated include.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 arch/arm/mach-tegra/timer.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 2f42021..9057d6f 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -28,7 +28,6 @@
 #include <linux/cnt32_to_63.h>
 
 #include <asm/mach/time.h>
-#include <asm/mach/time.h>
 #include <asm/localtimer.h>
 
 #include <mach/iomap.h>
-- 
1.7.2.2
