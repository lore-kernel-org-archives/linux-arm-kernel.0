From: baruch@tkos.co.il (Baruch Siach)
Date: Mon,  6 Jul 2015 14:41:44 +0300
Subject: [PATCH 2/4] ARM: multi_v7_defconfig: enable Conexant Digicolor
 watchdog
In-Reply-To: <cover.1436182214.git.baruch@tkos.co.il>
References: <cover.1436182214.git.baruch@tkos.co.il>
Message-ID: <0d23cb357ec46aa16cbe2d48bb6718e38cd7a282.1436182214.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6d83a1bf0c74..d0450e399a07 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -372,6 +372,7 @@ CONFIG_ORION_WATCHDOG=y
 CONFIG_ST_LPC_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MESON_WATCHDOG=y
+CONFIG_DIGICOLOR_WATCHDOG=y
 CONFIG_MFD_AS3711=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_BCM590XX=y
-- 
2.1.4
