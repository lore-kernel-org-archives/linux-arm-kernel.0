From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:19:01 +0900
Subject: [PATCH 09/21] ARM: shmobile: lager: Make spi_flash_data const
In-Reply-To: <cover.1391665225.git.horms+renesas@verge.net.au>
References: <cover.1391665225.git.horms+renesas@verge.net.au>
Message-ID: <d422c451a9795c7a10c3ae1ab7ca87ce7518546b.1391665225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index c5643e1..aa8f1d9 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -265,7 +265,7 @@ static struct mtd_partition spi_flash_part[] = {
 	},
 };
 
-static struct flash_platform_data spi_flash_data = {
+static const struct flash_platform_data spi_flash_data = {
 	.name           = "m25p80",
 	.parts          = spi_flash_part,
 	.nr_parts       = ARRAY_SIZE(spi_flash_part),
-- 
1.8.5.2
