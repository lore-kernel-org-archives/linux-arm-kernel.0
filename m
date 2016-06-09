From: rmk@armlinux.org.uk (Russell King)
Date: Thu, 09 Jun 2016 17:18:08 +0100
Subject: [PATCH] Remove "max" parameter comment
In-Reply-To: <20160608012257.GA28638@verge.net.au>
References: <20160608012257.GA28638@verge.net.au>
Message-ID: <E1bB2em-0004ll-0u@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the "max" parameter in the documentation for mem_regions_add()

Signed-off-by: Russell King <rmk@armlinux.org.uk>
---
 kexec/mem_regions.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
index b01a5c89..e61c0747 100644
--- a/kexec/mem_regions.c
+++ b/kexec/mem_regions.c
@@ -31,7 +31,6 @@ void mem_regions_sort(struct memory_ranges *ranges)
 /**
  * mem_regions_add() - add a memory region to a set of ranges
  * @ranges: ranges to add the memory region to
- * @max: maximum number of entries in memory region
  * @base: base address of memory region
  * @length: length of memory region in bytes
  * @type: type of memory region
-- 
1.9.1
