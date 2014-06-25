From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 25 Jun 2014 16:35:34 +0900
Subject: [PATCH 4/5] ARM: shmobile: armadillo800eva reference: Spelling
 s/ED/LED/
In-Reply-To: <cover.1403681531.git.horms+renesas@verge.net.au>
References: <cover.1403681531.git.horms+renesas@verge.net.au>
Message-ID: <8a0d1a2fcfd019adf9893076f6c65a9a05712853.1403681531.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

And add missing spaces before opening parentheses

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 368518b..0ae4982 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -53,11 +53,11 @@
  * CON22	Serial
  * CON23	LAN
  * CON24	USB3
- * LED1		Camera LED(Yellow)
+ * LED1		Camera LED (Yellow)
  * LED2		Power LED (Green)
- * ED3-LED6	User LED(Yellow)
- * LED7		LAN link LED(Green)
- * LED8		LAN activity LED(Yellow)
+ * LED3-LED6	User LED (Yellow)
+ * LED7		LAN link LED (Green)
+ * LED8		LAN activity LED (Yellow)
  */
 
 /*
-- 
2.0.0.rc2
