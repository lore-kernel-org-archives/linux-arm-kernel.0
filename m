From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed,  3 Aug 2011 17:34:46 +0800
Subject: [PATCH 14/17] mach-pnx4008: remove including old leds event API
	header file
In-Reply-To: <1312364089-32380-1-git-send-email-bryan.wu@canonical.com>
References: <1312364089-32380-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1312364089-32380-15-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-pnx4008/time.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pnx4008/time.c b/arch/arm/mach-pnx4008/time.c
index 0c8aad4..4385793 100644
--- a/arch/arm/mach-pnx4008/time.c
+++ b/arch/arm/mach-pnx4008/time.c
@@ -26,7 +26,6 @@
 
 #include <asm/system.h>
 #include <mach/hardware.h>
-#include <asm/leds.h>
 #include <asm/mach/time.h>
 #include <asm/errno.h>
 
-- 
1.7.5
