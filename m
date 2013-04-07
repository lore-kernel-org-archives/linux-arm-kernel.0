From: jhovold@gmail.com (Johan Hovold)
Date: Sun,  7 Apr 2013 16:49:59 +0200
Subject: [PATCH 2/2] ARM: at91: remove trailing semicolon from macros
In-Reply-To: <1365346199-29525-1-git-send-email-jhovold@gmail.com>
References: <1365346199-29525-1-git-send-email-jhovold@gmail.com>
Message-ID: <1365346199-29525-2-git-send-email-jhovold@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove trailing semicolon from register-access macros.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 arch/arm/mach-at91/at91_rstc.h                | 2 +-
 arch/arm/mach-at91/at91_shdwc.h               | 2 +-
 arch/arm/mach-at91/at91x40_time.c             | 2 +-
 arch/arm/mach-at91/include/mach/at91_matrix.h | 2 +-
 arch/arm/mach-at91/include/mach/at91_st.h     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-at91/at91_rstc.h b/arch/arm/mach-at91/at91_rstc.h
index 875fa33..a600e69 100644
--- a/arch/arm/mach-at91/at91_rstc.h
+++ b/arch/arm/mach-at91/at91_rstc.h
@@ -23,7 +23,7 @@ extern void __iomem *at91_rstc_base;
 	__raw_readl(at91_rstc_base + field)
 
 #define at91_rstc_write(field, value) \
-	__raw_writel(value, at91_rstc_base + field);
+	__raw_writel(value, at91_rstc_base + field)
 #else
 .extern at91_rstc_base
 #endif
diff --git a/arch/arm/mach-at91/at91_shdwc.h b/arch/arm/mach-at91/at91_shdwc.h
index 60478ea..9e29f31 100644
--- a/arch/arm/mach-at91/at91_shdwc.h
+++ b/arch/arm/mach-at91/at91_shdwc.h
@@ -23,7 +23,7 @@ extern void __iomem *at91_shdwc_base;
 	__raw_readl(at91_shdwc_base + field)
 
 #define at91_shdwc_write(field, value) \
-	__raw_writel(value, at91_shdwc_base + field);
+	__raw_writel(value, at91_shdwc_base + field)
 #endif
 
 #define AT91_SHDW_CR		0x00			/* Shut Down Control Register */
diff --git a/arch/arm/mach-at91/at91x40_time.c b/arch/arm/mach-at91/at91x40_time.c
index 0e57e44..f4c81c2 100644
--- a/arch/arm/mach-at91/at91x40_time.c
+++ b/arch/arm/mach-at91/at91x40_time.c
@@ -33,7 +33,7 @@
 	__raw_readl(AT91_IO_P2V(AT91_TC) + field)
 
 #define at91_tc_write(field, value) \
-	__raw_writel(value, AT91_IO_P2V(AT91_TC) + field);
+	__raw_writel(value, AT91_IO_P2V(AT91_TC) + field)
 
 /*
  *	3 counter/timer units present.
diff --git a/arch/arm/mach-at91/include/mach/at91_matrix.h b/arch/arm/mach-at91/include/mach/at91_matrix.h
index 02fae9d..f8996c9 100644
--- a/arch/arm/mach-at91/include/mach/at91_matrix.h
+++ b/arch/arm/mach-at91/include/mach/at91_matrix.h
@@ -14,7 +14,7 @@ extern void __iomem *at91_matrix_base;
 	__raw_readl(at91_matrix_base + field)
 
 #define at91_matrix_write(field, value) \
-	__raw_writel(value, at91_matrix_base + field);
+	__raw_writel(value, at91_matrix_base + field)
 
 #else
 .extern at91_matrix_base
diff --git a/arch/arm/mach-at91/include/mach/at91_st.h b/arch/arm/mach-at91/include/mach/at91_st.h
index 969aac2..67fdbd1 100644
--- a/arch/arm/mach-at91/include/mach/at91_st.h
+++ b/arch/arm/mach-at91/include/mach/at91_st.h
@@ -23,7 +23,7 @@ extern void __iomem *at91_st_base;
 	__raw_readl(at91_st_base + field)
 
 #define at91_st_write(field, value) \
-	__raw_writel(value, at91_st_base + field);
+	__raw_writel(value, at91_st_base + field)
 #else
 .extern at91_st_base
 #endif
-- 
1.8.1.5
