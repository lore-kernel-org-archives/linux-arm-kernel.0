From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 09 Jul 2013 19:40:16 +0900
Subject: [PATCH 04/04] ARM: shmobile: Remove unused mach/dma.h
In-Reply-To: <20130709103944.1891.67462.sendpatchset@w520>
References: <20130709103944.1891.67462.sendpatchset@w520>
Message-ID: <20130709104016.1891.68682.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove mach-shmobile mach/dma.h since it only
seems to be used on non-mach-shmobile platforms.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/dma.h |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/include/mach/dma.h
+++ /dev/null	2013-06-03 21:41:10.638032047 +0900
@@ -1 +0,0 @@
-/* empty */
