From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 8 Aug 2012 20:40:30 +0530
Subject: [PATCH] ASoC: Davinci: McASP: remove unused header include
Message-ID: <1344438632-2604-1-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Defines or parameters from <mach/mux.h> isn't used anywhere. Hence
remove the header include.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
This patch was tested on AM18x Board and is based on repo at 
http://git.kernel.org/?p=linux/kernel/git/broonie/sound.git;
a=shortlog;h=refs/heads/for-3.6

:100644 100644 10a2d8c... c80c20a... M	sound/soc/davinci/davinci-evm.c
 sound/soc/davinci/davinci-evm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 10a2d8c..c80c20a 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -24,7 +24,6 @@
 
 #include <mach/asp.h>
 #include <mach/edma.h>
-#include <mach/mux.h>
 
 #include "davinci-pcm.h"
 #include "davinci-i2s.h"
-- 
1.7.1
