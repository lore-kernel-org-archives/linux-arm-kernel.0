From: bs14@csr.com (Barry Song)
Date: Thu, 7 Jul 2011 19:54:27 -0700
Subject: [PATCH 1/3] ARM: CNS3XXX: add UL suffix to VMALLOC_END to ensure it
	is properly typed
In-Reply-To: <1310093669-4681-1-git-send-email-bs14@csr.com>
References: <1310093669-4681-1-git-send-email-bs14@csr.com>
Message-ID: <1310093669-4681-2-git-send-email-bs14@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Barry Song <baohua.song@csr.com>
---
 arch/arm/mach-cns3xxx/include/mach/vmalloc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/include/mach/vmalloc.h b/arch/arm/mach-cns3xxx/include/mach/vmalloc.h
index 4d381ec..1dd231d 100644
--- a/arch/arm/mach-cns3xxx/include/mach/vmalloc.h
+++ b/arch/arm/mach-cns3xxx/include/mach/vmalloc.h
@@ -8,4 +8,4 @@
  * published by the Free Software Foundation.
  */
 
-#define VMALLOC_END		0xd8000000
+#define VMALLOC_END		0xd8000000UL
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
