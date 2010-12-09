From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Thu,  9 Dec 2010 18:39:22 +0200
Subject: [PATCH 6/8] arm: omap: sdram-nokia: delete redundant timing data
In-Reply-To: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
References: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <1291912764-12823-7-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

41.5 MHz SDRAM clock is not usable.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/sdram-nokia.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/sdram-nokia.c b/arch/arm/mach-omap2/sdram-nokia.c
index 863586b..baf83ec 100644
--- a/arch/arm/mach-omap2/sdram-nokia.c
+++ b/arch/arm/mach-omap2/sdram-nokia.c
@@ -69,7 +69,6 @@ static const struct {
 	long rate;
 	struct sdram_timings const *data;
 } nokia_timings[] = {
-	{ 41500000, nokia_166mhz_timings },
 	{ 83000000, nokia_166mhz_timings },
 	{ 166000000, nokia_166mhz_timings },
 };
-- 
1.5.6.5
