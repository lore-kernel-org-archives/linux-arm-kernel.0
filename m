From: bryan.wu@canonical.com (Bryan Wu)
Date: Fri, 30 Mar 2012 19:58:30 +0800
Subject: [PATCH 15/18] ARM: mach-pnx4008: remove including old leds event API
 header file
In-Reply-To: <1333108713-12707-1-git-send-email-bryan.wu@canonical.com>
References: <1333108713-12707-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1333108713-12707-16-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-pnx4008/time.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pnx4008/time.c b/arch/arm/mach-pnx4008/time.c
index 0cfe8af..47a7ae9 100644
--- a/arch/arm/mach-pnx4008/time.c
+++ b/arch/arm/mach-pnx4008/time.c
@@ -25,7 +25,6 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <asm/leds.h>
 #include <asm/mach/time.h>
 #include <asm/errno.h>
 
-- 
1.7.9.1
