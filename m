From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 29 Apr 2016 22:40:19 +0200
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: add CONFIG_MICREL_PHY
In-Reply-To: <1461962419-4715-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1461962419-4715-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1461962419-4715-2-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver for Micrel PHYs is required for the Apalis iMX6 module
plugged into a Ixora carrier board featuring an on-module Micrel
KSZ9031 Gigabit PHY.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index fb959f9..71f8384 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -142,6 +142,7 @@ CONFIG_SMC911X=y
 CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 CONFIG_AT803X_PHY=y
+CONFIG_MICREL_PHY=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
 CONFIG_USB_RTL8152=m
-- 
2.5.5
