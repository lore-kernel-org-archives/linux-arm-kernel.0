From: galak@kernel.crashing.org (Kumar Gala)
Date: Fri, 20 Apr 2012 13:30:29 -0500
Subject: [PATCHv24 00/16] Contiguous Memory Allocator
In-Reply-To: <20120419124044.632bfa49.akpm@linux-foundation.org>
References: <1333462221-3987-1-git-send-email-m.szyprowski@samsung.com>
 <20120419124044.632bfa49.akpm@linux-foundation.org>
Message-ID: <D4B49754-F153-4600-AB79-49FD72D7D378@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek,

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index c1601e5..669e8bb 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -508,6 +508,11 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
                        Also note the kernel might malfunction if you disable
                        some critical bits.
 
+       cma=nn[MG]      [ARM,KNL]

Just a nit, but should that really have [ARM] ?

+                       Sets the size of kernel global memory area for contiguous
+                       memory allocations. For more information, see
+                       include/linux/dma-contiguous.h
+
