From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 15 Feb 2010 18:24:44 -0700
Subject: [PATCH 04/19] OMAP3: Clock: Added IDLEST definitions for SGX
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Message-ID: <20100216012443.1101.30955.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <tero.kristo@nokia.com>

Added definitions for OMAP3430ES2_ST_SGX_SHIFT and OMAP3430ES2_ST_SGX_MASK
as these were missing.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index a76e835..d18da47 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -379,6 +379,10 @@
 #define OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_SHIFT		1
 #define OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_MASK		(1 << 1)
 
+/* CM_IDLEST_SGX */
+#define OMAP3430ES2_ST_SGX_SHIFT			1
+#define OMAP3430ES2_ST_SGX_MASK				(1 << 1)
+
 /* CM_ICLKEN_SGX */
 #define OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_SHIFT		0
 #define OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_MASK		(1 << 0)
