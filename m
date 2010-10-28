From: mike@compulab.co.il (Mike Rapoport)
Date: Thu, 28 Oct 2010 21:23:53 +0200
Subject: [PATCH v4 2/2] [ARM] Dove: rename SDHCI devices to "sdhci-dove"
In-Reply-To: <cover.1288293593.git.mike@compulab.co.il>
References: <cover.1288293593.git.mike@compulab.co.il>
Message-ID: <d0ad0e29e3842b9ab786aad8a6efc15054114331.1288293593.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
CC: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/mach-dove/common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index f7a1258..fe627ab 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -770,7 +770,7 @@ static struct resource dove_sdio0_resources[] = {
 };
 
 static struct platform_device dove_sdio0 = {
-	.name		= "sdhci-mv",
+	.name		= "sdhci-dove",
 	.id		= 0,
 	.dev		= {
 		.dma_mask		= &sdio_dmamask,
@@ -798,7 +798,7 @@ static struct resource dove_sdio1_resources[] = {
 };
 
 static struct platform_device dove_sdio1 = {
-	.name		= "sdhci-mv",
+	.name		= "sdhci-dove",
 	.id		= 1,
 	.dev		= {
 		.dma_mask		= &sdio_dmamask,
-- 
1.7.3.1
