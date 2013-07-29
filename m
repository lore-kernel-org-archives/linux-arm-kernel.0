From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Jul 2013 00:04:16 -0300
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Add SATA support
In-Reply-To: <1375067056-6370-1-git-send-email-festevam@gmail.com>
References: <1375067056-6370-1-git-send-email-festevam@gmail.com>
Message-ID: <1375067056-6370-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Let SATA support be built by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index ab85d4a..2410bdc 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -97,6 +97,8 @@ CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
+CONFIG_SATA_AHCI_PLATFORM=y
+CONFIG_AHCI_IMX=y
 CONFIG_PATA_IMX=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_BROADCOM is not set
-- 
1.8.1.2
