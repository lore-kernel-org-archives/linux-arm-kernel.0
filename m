From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:52:55 +0900
Subject: [PATCH 06/19] ARM: dts: porter: fix JP3 jumper description
In-Reply-To: <cover.1456443769.git.horms+renesas@verge.net.au>
References: <cover.1456443769.git.horms+renesas@verge.net.au>
Message-ID: <f3b063c8f443049fb484086d6a956a5270f137a0.1456443769.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

When finishing the Porter sound support patch, I managed to call the JP3
jumper SW3 in the comment.  Fix this  along with (also miscalled) jumper
positions...

Fixes: 493b4da7c10c ("ARM: dts: porter: add sound support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index ed1f6f884e2b..bf3a0d13cd35 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -11,8 +11,8 @@
 /*
  * SSI-AK4642
  *
- * SW3: 1: AK4642
- *      3: ADV7511
+ * JP3: 2-1: AK4642
+ *      2-3: ADV7511
  *
  * This command is required before playback/capture:
  *
-- 
2.7.0.rc3.207.g0ac5344
