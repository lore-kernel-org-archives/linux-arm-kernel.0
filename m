From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 19 Dec 2017 13:34:56 +0000
Subject: [PATCH v3 1/5] ARM: shmobile: defconfig: Enable PWM
In-Reply-To: <1513690500-12165-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1513690500-12165-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1513690500-12165-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RZ/G1 and R-Car platforms have PWM timers. This patch enables PWM support
by default.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
v2->v3:
* No change

 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index d60dbe1..578434c 100644
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
2.7.4
