From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 30 Mar 2011 00:02:29 -0600
Subject: [PATCH] arm: fix build failure introduced by typo in irq namespace
	cleanup.
Message-ID: <20110330060229.27397.7628.stgit@ponder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 6845664a6a7d443f03883db59d10749d38d98b8e, "arm: Cleanup the irq
namespace" introduces a typo causing a build failure for the versatile
platform.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/mach-versatile/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 96e59e3..eb7ffa0 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -314,7 +314,7 @@ static struct mmci_platform_data mmc0_plat_data = {
 	.gpio_cd	= -1,
 };
 
-static struct resource chalcd_resources[] = {
+static struct resource char_lcd_resources[] = {
 	{
 		.start = VERSATILE_CHAR_LCD_BASE,
 		.end   = (VERSATILE_CHAR_LCD_BASE + SZ_4K - 1),
