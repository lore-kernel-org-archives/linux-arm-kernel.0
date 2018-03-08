From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  8 Mar 2018 17:09:29 +0900
Subject: [PATCH] ASoC: uniphier: remove superfluous <linux/mfd/syscon.h>
 inclusion
Message-ID: <1520496569-32032-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

None of aio-compress.c depends on the syscon header.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---

 sound/soc/uniphier/aio-compress.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/uniphier/aio-compress.c b/sound/soc/uniphier/aio-compress.c
index 4751c8b..4c1027a 100644
--- a/sound/soc/uniphier/aio-compress.c
+++ b/sound/soc/uniphier/aio-compress.c
@@ -22,7 +22,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
-- 
2.7.4
