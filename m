From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Wed, 19 May 2010 18:46:03 +0200
Subject: [PATCH 08/13] mach-cpuimx27: register wdt and w1_master resources
In-Reply-To: <1274287568-30253-7-git-send-email-eric@eukrea.com>
References: <1274287568-30253-1-git-send-email-eric@eukrea.com>
	<1274287568-30253-2-git-send-email-eric@eukrea.com>
	<1274287568-30253-3-git-send-email-eric@eukrea.com>
	<1274287568-30253-4-git-send-email-eric@eukrea.com>
	<1274287568-30253-5-git-send-email-eric@eukrea.com>
	<1274287568-30253-6-git-send-email-eric@eukrea.com>
	<1274287568-30253-7-git-send-email-eric@eukrea.com>
Message-ID: <1274287568-30253-8-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx2/mach-cpuimx27.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/mach-cpuimx27.c b/arch/arm/mach-mx2/mach-cpuimx27.c
index 19877f1..dc2dca3 100644
--- a/arch/arm/mach-mx2/mach-cpuimx27.c
+++ b/arch/arm/mach-mx2/mach-cpuimx27.c
@@ -162,6 +162,8 @@ static struct mxc_nand_platform_data eukrea_cpuimx27_nand_board_info = {
 static struct platform_device *platform_devices[] __initdata = {
 	&eukrea_cpuimx27_nor_mtd_device,
 	&mxc_fec_device,
+	&mxc_wdt,
+	&mxc_w1_master_device,
 };
 
 static struct imxi2c_platform_data eukrea_cpuimx27_i2c_1_data = {
-- 
1.6.3.3
