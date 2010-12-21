From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 20 Dec 2010 21:39:46 -0700
Subject: [PATCH] ARM: Add missing SZ_{32,64,128}
In-Reply-To: <20101220093017.GS1940@pengutronix.de>
References: <20101220093017.GS1940@pengutronix.de>
Message-ID: <1292906386-15195-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... and also remove misleading comment stating that this header is
auto-generated.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/include/asm/sizes.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/sizes.h b/arch/arm/include/asm/sizes.h
index 4fc1565..316bb2b 100644
--- a/arch/arm/include/asm/sizes.h
+++ b/arch/arm/include/asm/sizes.h
@@ -13,9 +13,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-/* DO NOT EDIT!! - this file automatically generated
- *                 from .s file by awk -f s2h.awk
- */
 /*  Size definitions
  *  Copyright (C) ARM Limited 1998. All rights reserved.
  */
@@ -25,6 +22,9 @@
 
 /* handy sizes */
 #define SZ_16				0x00000010
+#define SZ_32				0x00000020
+#define SZ_64				0x00000040
+#define SZ_128				0x00000080
 #define SZ_256				0x00000100
 #define SZ_512				0x00000200
 
-- 
1.7.2.3
nvpublic
