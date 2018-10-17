From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 17 Oct 2018 12:07:22 +0200
Subject: [PATCH] arm64: renesas_defconfig: Enable R-Car thermal driver
Message-ID: <20181017100722.29481-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the R-Car thermal driver.

This driver is used in conjunction with the R-Car V3M (r8a77970),
E3 (r8a77990) and D3 (r8a77995) SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
N.B: This is targeted at the devel branch of the renesas tree
but not upstream where renesas_defconfig does not currently exist
---
 arch/arm64/configs/renesas_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/renesas_defconfig b/arch/arm64/configs/renesas_defconfig
index f8fca4a777da..b7298a389568 100644
--- a/arch/arm64/configs/renesas_defconfig
+++ b/arch/arm64/configs/renesas_defconfig
@@ -154,6 +154,7 @@ CONFIG_THERMAL=y
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
+CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_RENESAS_WDT=y
-- 
2.11.0
