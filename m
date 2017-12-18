From: linux-kernel-dev@beckhoff.com (linux-kernel-dev at beckhoff.com)
Date: Mon, 18 Dec 2017 12:51:33 +0100
Subject: [PATCH v4 4/4] ARM: imx_v6_v7_defconfig: enable RTC_DRV_MXC_V2
In-Reply-To: <20171218115133.16371-1-linux-kernel-dev@beckhoff.com>
References: <20171218115133.16371-1-linux-kernel-dev@beckhoff.com>
Message-ID: <20171218115133.16371-5-linux-kernel-dev@beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Bruenn <p.bruenn@beckhoff.com>

Enable SRTC driver for i.MX53 in default config

Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>

---
v3:
- imx_v4_v5_defconfig was the wrong default config for i.MX53

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de> (maintainer:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: linux-rtc at vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
Cc: devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: linux-kernel at vger.kernel.org (open list)
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Juergen Borleis <jbe@pengutronix.de>
Cc: Noel Vellemans <Noel.Vellemans@visionbms.com>
Cc: Russell King <linux@armlinux.org.uk> (maintainer:ARM PORT)
Cc: linux-arm-kernel at lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)

Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0d4494922561..548c11142a4e 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -349,6 +349,7 @@ CONFIG_RTC_DRV_PCF8563=y
 CONFIG_RTC_DRV_M41T80=y
 CONFIG_RTC_DRV_MC13XXX=y
 CONFIG_RTC_DRV_MXC=y
+CONFIG_RTC_DRV_MXC_V2=y
 CONFIG_RTC_DRV_SNVS=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_EDMA=y
-- 
2.11.0
