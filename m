From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 25 Feb 2011 14:38:29 +0100
Subject: [PATCH 4/6] cpuimx51sd: mcp2515 supports up to 10MHz SPI clock
In-Reply-To: <1298641111-12957-1-git-send-email-eric@eukrea.com>
References: <1298641111-12957-1-git-send-email-eric@eukrea.com>
Message-ID: <1298641111-12957-4-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx5/board-cpuimx51sd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index 5b19419..4d4e8e4 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -237,7 +237,7 @@ static struct mcp251x_platform_data mcp251x_info = {
 static struct spi_board_info cpuimx51sd_spi_device[] = {
 	{
 		.modalias        = "mcp2515",
-		.max_speed_hz    = 6500000,
+		.max_speed_hz    = 10000000,
 		.bus_num         = 0,
 		.mode		= SPI_MODE_0,
 		.chip_select     = 0,
-- 
1.7.4
