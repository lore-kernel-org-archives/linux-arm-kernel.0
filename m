From: b32955@freescale.com (Huang Shijie)
Date: Mon, 8 Jul 2013 15:16:03 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: enable WEIM driver
Message-ID: <1373267763-28440-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable the weim driver.
Since the NOR is connected to the WEIM for imx6q{dl}-sabreauto,
we also enable the MTD_PHYSMAP_OF module.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index f64b6a2..f1662d3 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -68,6 +68,7 @@ CONFIG_NETFILTER=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
+CONFIG_IMX_WEIM=y
 CONFIG_CONNECTOR=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
@@ -78,6 +79,7 @@ CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
+CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_DATAFLASH=y
 CONFIG_MTD_M25P80=y
 CONFIG_MTD_SST25L=y
-- 
1.7.1
