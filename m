From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 00:48:19 -0500
Subject: [PATCH 01/23] ARM: mach-dove: remove inclusion of <mach/vmalloc.h>
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <1321422521-1138-2-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

This include is unnecessary.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-dove/include/mach/dove.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-dove/include/mach/dove.h b/arch/arm/mach-dove/include/mach/dove.h
index b20ec9af78..ad1165d488 100644
--- a/arch/arm/mach-dove/include/mach/dove.h
+++ b/arch/arm/mach-dove/include/mach/dove.h
@@ -11,8 +11,6 @@
 #ifndef __ASM_ARCH_DOVE_H
 #define __ASM_ARCH_DOVE_H
 
-#include <mach/vmalloc.h>
-
 /*
  * Marvell Dove address maps.
  *
-- 
1.7.7.1.431.g10b2a
