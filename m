From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 20 Oct 2014 16:19:25 +0300
Subject: [PATCH 2/2] ARM: keystone_defconfig: enable mdio and marvell eth phys
In-Reply-To: <1413811165-3928-1-git-send-email-grygorii.strashko@ti.com>
References: <1413811165-3928-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1413811165-3928-2-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable MDIO support for Keystone 2 SoCs and also
enable Marvell Ethernet PHYs support for Keystone 2 K2H EVM
which has two 1G Marvell 88E1111-B2 PHYs installed.

For more information see:
- http://www.advantech.com/Support/TI-EVM/EVMK2HX.aspx

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index c9b0d1b..4c799b5 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -196,3 +196,5 @@ CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_KEYSTONE_IRQ=y
 CONFIG_GPIO_SYSCON=y
+CONFIG_TI_DAVINCI_MDIO=y
+CONFIG_MARVELL_PHY=y
-- 
1.9.1
