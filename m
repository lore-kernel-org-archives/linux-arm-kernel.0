From: Baohua.Song@csr.com (Barry Song)
Date: Mon, 17 Jun 2013 09:44:26 +0800
Subject: [PATCH] MAINTAINERS: ARM: SIRF: add the source code tree path
Message-ID: <1371433466-8548-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I got an account "baohua" from kernel.org and I'll use this tree
to maintain CSR SoCs stuff:
git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 250dc97..c6f6b7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -797,6 +797,7 @@ F:	arch/arm/mach-gemini/
 ARM/CSR SIRFPRIMA2 MACHINE SUPPORT
 M:	Barry Song <baohua.song@csr.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
 S:	Maintained
 F:	arch/arm/mach-prima2/
 F:	drivers/dma/sirf-dma.c
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
