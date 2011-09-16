From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Sep 2011 03:07:15 -0400
Subject: [PATCH 04/19] ARM: plat-mxc: remove inclusion of <mach/vmalloc.h>
In-Reply-To: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
Message-ID: <1316156850-31013-5-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/plat-mxc/include/mach/mx1.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx1.h b/arch/arm/plat-mxc/include/mach/mx1.h
index 97b19e7800..2b7c08d13e 100644
--- a/arch/arm/plat-mxc/include/mach/mx1.h
+++ b/arch/arm/plat-mxc/include/mach/mx1.h
@@ -12,8 +12,6 @@
 #ifndef __MACH_MX1_H__
 #define __MACH_MX1_H__
 
-#include <mach/vmalloc.h>
-
 /*
  * Memory map
  */
-- 
1.7.7-rc0
