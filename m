From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 16 Sep 2015 14:03:01 -0500
Subject: [PATCH 2/7] arm64: Shorten lines which exceed 80 characters
In-Reply-To: <1442430186-9083-1-git-send-email-jeremy.linton@arm.com>
References: <1442430186-9083-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1442430186-9083-3-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PTE definitions in this file exceed 80 characters

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 24154b0..4489cf6 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -99,14 +99,14 @@
 #define PTE_TYPE_FAULT		(_AT(pteval_t, 0) << 0)
 #define PTE_TYPE_PAGE		(_AT(pteval_t, 3) << 0)
 #define PTE_TABLE_BIT		(_AT(pteval_t, 1) << 1)
-#define PTE_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
-#define PTE_RDONLY		(_AT(pteval_t, 1) << 7)		/* AP[2] */
-#define PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
-#define PTE_AF			(_AT(pteval_t, 1) << 10)	/* Access Flag */
-#define PTE_NG			(_AT(pteval_t, 1) << 11)	/* nG */
-#define PTE_DBM			(_AT(pteval_t, 1) << 51)	/* Dirty Bit Management */
-#define PTE_PXN			(_AT(pteval_t, 1) << 53)	/* Privileged XN */
-#define PTE_UXN			(_AT(pteval_t, 1) << 54)	/* User XN */
+#define PTE_USER		(_AT(pteval_t, 1) << 6)  /* AP[1] */
+#define PTE_RDONLY		(_AT(pteval_t, 1) << 7)  /* AP[2] */
+#define PTE_SHARED		(_AT(pteval_t, 3) << 8)  /* inner shareable */
+#define PTE_AF			(_AT(pteval_t, 1) << 10) /* Access Flag */
+#define PTE_NG			(_AT(pteval_t, 1) << 11) /* nG */
+#define PTE_DBM			(_AT(pteval_t, 1) << 51) /* Dirty Bit Mgmt */
+#define PTE_PXN			(_AT(pteval_t, 1) << 53) /* Privileged XN */
+#define PTE_UXN			(_AT(pteval_t, 1) << 54) /* User XN */
 
 /*
  * AttrIndx[2:0] encoding (mapping attributes defined in the MAIR* registers).
-- 
2.4.3
