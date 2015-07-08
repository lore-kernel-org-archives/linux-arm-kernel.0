From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 8 Jul 2015 20:57:34 +0530
Subject: [PATCH 1/4] ARM: omap2plus_defconfig: enable support for TI ADC
In-Reply-To: <cover.1436368740.git.nsekhar@ti.com>
References: <cover.1436368740.git.nsekhar@ti.com>
Message-ID: <51df3b0ac6d50feae98c3916cded3a25527d80c2.1436368740.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for on-chip ADC found on AM335x and
AM437x devices.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index ac521e764d10..a8eb36454b14 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -269,6 +269,7 @@ CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65217=y
 CONFIG_MFD_TPS65218=y
 CONFIG_MFD_TPS65910=y
+CONFIG_MFD_TI_AM335X_TSCADC=m
 CONFIG_TWL6040_CORE=y
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_PBIAS=y
@@ -398,6 +399,8 @@ CONFIG_EXTCON=m
 CONFIG_EXTCON_USB_GPIO=m
 CONFIG_EXTCON_PALMAS=m
 CONFIG_TI_EMIF=m
+CONFIG_IIO=m
+CONFIG_TI_AM335X_ADC=m
 CONFIG_PWM=y
 CONFIG_PWM_TIECAP=m
 CONFIG_PWM_TIEHRPWM=m
-- 
2.4.4.408.g16da57c
