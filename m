From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 9 Nov 2009 14:40:47 +0800
Subject: [PATCH 2/3] [ARM] pxa: select CPU_PXA310 for MACH_COLIBRI300
Message-ID: <mailman.2.1257749471.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MACH_COLIBRI300 is supposed to support both PXA300 and PXA310, select
the missing CPU_PXA310.

Cc: Daniel Mack <daniel@caiaq.de>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index ca2bd59..4bd0f87 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -254,6 +254,7 @@ config MACH_COLIBRI300
 	bool "Toradex Colibri PXA300/310"
 	select PXA3xx
 	select CPU_PXA300
+	select CPU_PXA310

 config MACH_COLIBRI320
 	bool "Toradex Colibri PXA320"
-- 
1.6.3.3
