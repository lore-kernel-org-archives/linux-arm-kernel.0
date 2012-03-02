From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:22 -0600
Subject: [PATCH v3 10/30] ARM: davinci: remove unneeded mach/io.h include
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-11-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

entry-macro.S doesn't actually need mach/io.h, so remove it.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-davinci/include/mach/entry-macro.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/entry-macro.S b/arch/arm/mach-davinci/include/mach/entry-macro.S
index e14c0dc..f6e1d33 100644
--- a/arch/arm/mach-davinci/include/mach/entry-macro.S
+++ b/arch/arm/mach-davinci/include/mach/entry-macro.S
@@ -8,7 +8,6 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#include <mach/io.h>
 #include <mach/irqs.h>
 
 		.macro	disable_fiq
-- 
1.7.5.4
