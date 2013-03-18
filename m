From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:07:07 +0900
Subject: [PATCH 131/142] ARM: shmobile: sh73a0: Remove USB function GPIOs
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-132-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/sh73a0.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index 218e6b7..d488e2b 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -94,8 +94,7 @@ enum {
 	GPIO_PORT305, GPIO_PORT306, GPIO_PORT307, GPIO_PORT308, GPIO_PORT309,
 
 	/* Table 25-1 (Function 0-7) */
-	GPIO_FN_VBUS_0 = 310,
-	GPIO_FN_GPI0,
+	GPIO_FN_GPI0 = 310,
 	GPIO_FN_GPI1,
 	GPIO_FN_GPI2,
 	GPIO_FN_GPI3,
-- 
1.7.10.4
