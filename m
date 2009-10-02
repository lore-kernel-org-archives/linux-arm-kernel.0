From: tony@atomide.com (Tony Lindgren)
Date: Fri, 02 Oct 2009 15:41:33 -0700
Subject: [PATCH 4/8] omap: iovmm: Fix incorrect spelling
In-Reply-To: <20091002223510.11962.21751.stgit@localhost>
References: <20091002223510.11962.21751.stgit@localhost>
Message-ID: <20091002224133.11962.84509.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Fix incorrect spelling

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/iovmm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 57f7122..0e5573d 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -47,7 +47,7 @@
  *	'va':	mpu virtual address
  *
  *	'c':	contiguous memory area
- *	'd':	dicontiguous memory area
+ *	'd':	discontiguous memory area
  *	'a':	anonymous memory allocation
  *	'()':	optional feature
  *
@@ -398,7 +398,7 @@ static inline void sgtable_drain_vmalloc(struct sg_table *sgt)
 {
 	/*
 	 * Actually this is not necessary at all, just exists for
-	 * consistency of the code readibility.
+	 * consistency of the code readability.
 	 */
 	BUG_ON(!sgt);
 }
@@ -434,7 +434,7 @@ static inline void sgtable_drain_kmalloc(struct sg_table *sgt)
 {
 	/*
 	 * Actually this is not necessary at all, just exists for
-	 * consistency of the code readibility
+	 * consistency of the code readability
 	 */
 	BUG_ON(!sgt);
 }
