From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:29:41 +0100
Subject: [PATCH 3/3] ARM: shmobile: defconfig: Enable PWM
In-Reply-To: <cover.1513935930.git.horms+renesas@verge.net.au>
References: <cover.1513935930.git.horms+renesas@verge.net.au>
Message-ID: <1943cbd3b39ee3310494d5b531a906e836bb9f7f.1513935930.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

RZ/G1 and R-Car platforms have PWM timers. This patch enables PWM support
by default.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index d60dbe1f108f..578434cfd1a0 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -208,6 +208,7 @@ CONFIG_STAGING_BOARD=y
 CONFIG_IIO=y
 CONFIG_AK8975=y
 CONFIG_PWM=y
+CONFIG_PWM_RCAR=y
 CONFIG_PWM_RENESAS_TPU=y
 CONFIG_GENERIC_PHY=y
 CONFIG_PHY_RCAR_GEN2=y
-- 
2.11.0
