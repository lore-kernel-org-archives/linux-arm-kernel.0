From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:27 -0600
Subject: [PATCH v3 15/30] ARM: dove: add explicit include of dove.h to
 addr-map.c
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-16-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to remove mach/io.h, add explicit include of mach/dove.h

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-dove/addr-map.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-dove/addr-map.c b/arch/arm/mach-dove/addr-map.c
index 98b8c83..2a06c01 100644
--- a/arch/arm/mach-dove/addr-map.c
+++ b/arch/arm/mach-dove/addr-map.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <asm/mach/arch.h>
 #include <asm/setup.h>
+#include <mach/dove.h>
 #include <plat/addr-map.h>
 #include "common.h"
 
-- 
1.7.5.4
