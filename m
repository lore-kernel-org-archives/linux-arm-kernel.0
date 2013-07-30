From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jul 2013 16:59:45 +0200
Subject: [PATCH 01/10] ARM: sunxi: Introduce Allwinner A20 support
In-Reply-To: <1375196394-21138-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375196394-21138-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1375196394-21138-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A20 is a dual-core Cortex-A7-based SoC. It is
pin-compatible with the A10, and re-uses most of the IPs found in it,
plus some additional ones like a Gigabit Ethernet controller.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 19bcc96..b9b2db6 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -134,6 +134,7 @@ static const char * const sunxi_board_dt_compat[] = {
 	"allwinner,sun5i-a10s",
 	"allwinner,sun5i-a13",
 	"allwinner,sun6i-a31",
+	"allwinner,sun7i-a20",
 	NULL,
 };
 
-- 
1.8.3.4
