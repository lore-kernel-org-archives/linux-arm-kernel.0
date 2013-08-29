From: geoff@infradead.org (Geoff Levand)
Date: Thu, 29 Aug 2013 14:38:27 -0700
Subject: [PATCH] arm64: Add EM_AARCH64 to elf-em.h
Message-ID: <1377812307.23710.3.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the elf EM value for ARM's AArch64.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---

Hi Catalin,

Please apply if you don't have it yet.

-Geoff

 include/uapi/linux/elf-em.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index 8e2b7ba..16259b4 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -34,6 +34,7 @@
 #define EM_MN10300	89	/* Panasonic/MEI MN10300, AM33 */
 #define EM_BLACKFIN     106     /* ADI Blackfin Processor */
 #define EM_TI_C6000	140	/* TI C6X DSPs */
+#define EM_AARCH64	183	/* ARM AARCH64 */
 #define EM_FRV		0x5441	/* Fujitsu FR-V */
 #define EM_AVR32	0x18ad	/* Atmel AVR32 */
 
-- 
1.8.1.2
