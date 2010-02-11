From: richardliu@ms1.techarea.org (Richard Liu)
Date: Thu, 11 Feb 2010 16:27:16 +0800
Subject: Clean/Invalidate L1/L2 DCache on userspace.
Message-ID: <4B73BF64.7030603@ms1.techarea.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All:

     Does any one try to clean/invalidate L2 Dcache for userspace memory?

Program allocated a memory from malloc on userspace.
Tried to pass userspace memory point to kernel and use function 
"dma_cache_maint" to flush/invalidate it.
But it's not work.

     sys_cacheflush seems only flush L1 and icache only.
It doesn't fit my requirement.
So, I cannot find any solution to clean/invalidate L2 Dcache from user 
space.
