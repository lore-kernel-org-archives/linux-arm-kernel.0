From: nikai@nikai.net (Nicolas Kaiser)
Date: Mon, 4 Oct 2010 12:39:01 +0200
Subject: [PATCH 1/5] arm/nomadik: remove duplicated include
In-Reply-To: <20101004122436.7092868f@absol.kitzblitz>
References: <20101004122436.7092868f@absol.kitzblitz>
Message-ID: <20101004123901.6374d158@absol.kitzblitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated include.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 arch/arm/plat-nomadik/include/plat/ste_dma40.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-nomadik/include/plat/ste_dma40.h b/arch/arm/plat-nomadik/include/plat/ste_dma40.h
index 5fbde4b..93a8126 100644
--- a/arch/arm/plat-nomadik/include/plat/ste_dma40.h
+++ b/arch/arm/plat-nomadik/include/plat/ste_dma40.h
@@ -14,7 +14,6 @@
 #include <linux/dmaengine.h>
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
-#include <linux/dmaengine.h>
 
 /* dev types for memcpy */
 #define STEDMA40_DEV_DST_MEMORY (-1)
-- 
1.7.2.2
