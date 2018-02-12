From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 12 Feb 2018 17:44:23 +0000
Subject: [PATCH v5 14/26] ARM: shmobile: defconfig: Enable RENESAS_WDT_GEN
In-Reply-To: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1518457475-4480-15-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Car Gen2 and RZ/G1 platforms come with a watchdog IP, therefore enable
its driver by default.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v4->v5:
* no change

 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 578434c..d5cdad8 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -132,6 +132,7 @@ CONFIG_CPU_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_DA9063_WATCHDOG=y
+CONFIG_RENESAS_WDT=y
 CONFIG_MFD_AS3711=y
 CONFIG_MFD_DA9063=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-- 
2.7.4
