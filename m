From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 22 Oct 2015 11:18:53 +0200
Subject: [PATCH 3/4] arm: plat-omap: add DT support for ti,dm816-timer
Message-ID: <5628A9FD.5030709@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds ti,dm816-timer to the dmtimer OF match table.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/plat-omap/dmtimer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 8ca94d3..28a6550 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -943,6 +943,10 @@ static const struct of_device_id omap_timer_match[] = {
 		.compatible = "ti,am335x-timer-1ms",
 		.data = &omap3plus_pdata,
 	},
+	{
+		.compatible = "ti,dm816-timer",
+		.data = &omap3plus_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_timer_match);
-- 
1.9.1
