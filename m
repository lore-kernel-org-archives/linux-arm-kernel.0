From: denis@eukrea.com (Denis Carikli)
Date: Mon, 21 Oct 2013 15:54:27 +0200
Subject: [PATCHv4][ 4/4] ARM: imx_v6_v7_defconfig: Enable tsc2007 support.
In-Reply-To: <1382363667-10341-1-git-send-email-denis@eukrea.com>
References: <1382363667-10341-1-git-send-email-denis@eukrea.com>
Message-ID: <1382363667-10341-4-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eukrea cpuimx35 and cpuimx51 have a tsc2007 touchscreen controller,
  so we turn it on.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Eric B?nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v2->v4:
- This patch was splitted, only the part enabling the audio was kept.
  Part of the rest has already been submited, and the remaining parts
  will be submited later, because they depend on changes touching other
  subsystems.
---
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index d8a52a0..23ba17d 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -130,6 +130,7 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_EGALAX=y
 CONFIG_TOUCHSCREEN_MC13783=y
+CONFIG_TOUCHSCREEN_TSC2007=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MMA8450=y
 CONFIG_SERIO_SERPORT=m
-- 
1.7.9.5
