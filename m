From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:29:40 +0100
Subject: [PATCH 2/3] ARM: multi_v7_defconfig: Select PWM_RCAR as module
In-Reply-To: <cover.1513935930.git.horms+renesas@verge.net.au>
References: <cover.1513935930.git.horms+renesas@verge.net.au>
Message-ID: <7c57fbcf1455e6823ac6ce44ab45cc351bd79b42.1513935930.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Enable PWM support for R-Car and friends by default.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 61509c4b769f..b4c36f99f0fa 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -879,6 +879,7 @@ CONFIG_PWM_ATMEL=m
 CONFIG_PWM_ATMEL_HLCDC_PWM=m
 CONFIG_PWM_ATMEL_TCB=m
 CONFIG_PWM_FSL_FTM=m
+CONFIG_PWM_RCAR=m
 CONFIG_PWM_RENESAS_TPU=y
 CONFIG_PWM_ROCKCHIP=m
 CONFIG_PWM_SAMSUNG=m
-- 
2.11.0
