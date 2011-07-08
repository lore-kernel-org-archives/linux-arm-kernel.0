From: bs14@csr.com (Barry Song)
Date: Thu, 7 Jul 2011 19:54:28 -0700
Subject: [PATCH 2/3] ARM: LPC32XXX: add UL suffix to VMALLOC_END to ensure it
	is properly typed
In-Reply-To: <1310093669-4681-1-git-send-email-bs14@csr.com>
References: <1310093669-4681-1-git-send-email-bs14@csr.com>
Message-ID: <1310093669-4681-3-git-send-email-bs14@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Barry Song <baohua.song@csr.com>
---
 arch/arm/mach-lpc32xx/include/mach/vmalloc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/include/mach/vmalloc.h b/arch/arm/mach-lpc32xx/include/mach/vmalloc.h
index d1d936c..720fa43 100644
--- a/arch/arm/mach-lpc32xx/include/mach/vmalloc.h
+++ b/arch/arm/mach-lpc32xx/include/mach/vmalloc.h
@@ -19,6 +19,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END	0xF0000000
+#define VMALLOC_END	0xF0000000UL
 
 #endif
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
