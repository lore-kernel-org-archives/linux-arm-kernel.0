From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 08 Jul 2016 17:24:48 +0200
Subject: [RESEND PATCH] arm: pxa255-idp_defconfig: disable IDE subsystem
In-Reply-To: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1467991490-24895-8-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch disables deprecated IDE subsystem in pxa255-idp_defconfig
(no IDE host drivers are selected in this config so there is no valid
reason to enable IDE subsystem itself).

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/configs/pxa255-idp_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/pxa255-idp_defconfig b/arch/arm/configs/pxa255-idp_defconfig
index 917a070b..088627a 100644
--- a/arch/arm/configs/pxa255-idp_defconfig
+++ b/arch/arm/configs/pxa255-idp_defconfig
@@ -28,7 +28,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
 # CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
 # CONFIG_MTD_CFI_I1 is not set
 CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_IDE=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
-- 
1.9.1
