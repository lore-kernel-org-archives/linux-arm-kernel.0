From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 11 Jan 2014 14:16:16 -0200
Subject: [PATCH] ARM: multi_v7_defconfig: Select CONFIG_AT803X_PHY
Message-ID: <1389456976-5110-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Select CONFIG_AT803X_PHY so that we can boot hummingboard via NFS.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e2c0734..7a48a00 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -114,6 +114,7 @@ CONFIG_R8169=y
 CONFIG_SMSC911X=y
 CONFIG_STMMAC_ETH=y
 CONFIG_TI_CPSW=y
+CONFIG_AT803X_PHY=y
 CONFIG_ICPLUS_PHY=y
 CONFIG_USB_PEGASUS=y
 CONFIG_USB_USBNET=y
-- 
1.8.1.2
