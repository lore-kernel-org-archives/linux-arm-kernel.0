From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:17:28 +0900
Subject: [PATCH 2/7] ARM: shmobile: fix sample amixer settings for mackerel
In-Reply-To: <1359080253-30995-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080253-30995-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080253-30995-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates FSI-AK4643 amixer setting

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 2fed62f..002eaf6 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -202,9 +202,7 @@
  *
  * it needs amixer settings for playing
  *
- * amixer set "Headphone" on
- * amixer set "HPOUTL Mixer DACH" on
- * amixer set "HPOUTR Mixer DACH" on
+ * amixer set "Headphone Enable" on
  */
 
 /* Fixed 3.3V and 1.8V regulators to be used by multiple devices */
-- 
1.7.10.4
