From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 21 May 2012 00:20:13 -0300
Subject: [PATCH] ARM: mxs: Let GPMI driver be built by default
Message-ID: <1337570413-31407-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Let GPMI driver be built by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/mxs_defconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 5406c23..6b86df7 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -58,6 +58,9 @@ CONFIG_CAN_FLEXCAN=m
 CONFIG_DEVTMPFS=y
 # CONFIG_FIRMWARE_IN_KERNEL is not set
 # CONFIG_BLK_DEV is not set
+CONFIG_MTD=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_ENC28J60=y
-- 
1.7.1
