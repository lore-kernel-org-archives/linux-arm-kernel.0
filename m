From: markus.mayer@linaro.org (Markus Mayer)
Date: Tue, 25 Feb 2014 14:17:45 -0800
Subject: [PATCH 3/4] ARM: bcm281xx: Re-order hearder files
In-Reply-To: <1393366666-28625-1-git-send-email-markus.mayer@linaro.org>
References: <1393366666-28625-1-git-send-email-markus.mayer@linaro.org>
Message-ID: <1393366666-28625-4-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-order header files alphabetically.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
---
 arch/arm/mach-bcm/board_bcm281xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-bcm/board_bcm281xx.c b/arch/arm/mach-bcm/board_bcm281xx.c
index e0d0bc5e..fe00ff3 100644
--- a/arch/arm/mach-bcm/board_bcm281xx.c
+++ b/arch/arm/mach-bcm/board_bcm281xx.c
@@ -11,9 +11,9 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/of_platform.h>
-#include <linux/of_address.h>
 #include <linux/clocksource.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
 
-- 
1.7.9.5
