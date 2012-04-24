From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 24 Apr 2012 20:35:37 -0300
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Add SPI NOR support
In-Reply-To: <1335310537-11219-1-git-send-email-festevam@gmail.com>
References: <1335310537-11219-1-git-send-email-festevam@gmail.com>
Message-ID: <1335310537-11219-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SPI NOR support in defconfig.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index ff562c9..0a0eacb 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -64,6 +64,13 @@ CONFIG_IPV6=y
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_MTD=y
+CONFIG_MTD_OF_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_DATAFLASH=y
+CONFIG_MTD_M25P80=y
+CONFIG_M25PXX_USE_FAST_READ=y
+CONFIG_MTD_SST25L=y
 # CONFIG_STANDALONE is not set
 CONFIG_CONNECTOR=y
 CONFIG_BLK_DEV_LOOP=y
-- 
1.7.1
