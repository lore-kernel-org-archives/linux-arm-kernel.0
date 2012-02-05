From: jj@chaosbits.net (Jesper Juhl)
Date: Sun, 5 Feb 2012 01:22:29 +0100 (CET)
Subject: [PATCH] ARM: Remove duplicate asm/memblock.h include from
 arch/arm/mm/init.c
Message-ID: <alpine.LNX.2.00.1202050121060.30244@swampdragon.chaosbits.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need to include the header twice, so get rid of the
duplicate.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 arch/arm/mm/init.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 5dc7d12..245a55a 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -32,7 +32,6 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/memblock.h>
 
 #include "mm.h"
 
-- 
1.7.9


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
