From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Feb 2012 15:43:21 -0600
Subject: [PATCH 08/15] ARM: davinci: remove unneeded mach/io.h include
In-Reply-To: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
Message-ID: <1329169408-17253-9-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

entry-macro.S doesn't actually need mach/io.h, so remove it.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
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
