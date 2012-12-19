From: marex@denx.de (Marek Vasut)
Date: Wed, 19 Dec 2012 18:32:58 +0100
Subject: [PATCH 0/8] arm: mxs: Various mxs_defconfig adjustments
Message-ID: <1355938386-14582-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enables various config options, mostly needed to
get MX28EVK and M28EVK decently working.

Marek Vasut (8):
  arm: mxs: Regenerate mxs_defconfig to match recent kernel
  arm: mxs: Enable MTD block access
  arm: mxs: Enable UBI and UBIFS
  arm: mxs: Enable JFFS2
  arm: mxs: Enable EXT2 and EXT4
  arm: mxs: Enable AT24 EEPROM support
  arm: mxs: Enable support for most SPI flashes
  arm: mxs: Enable most commonly used PHYs

 arch/arm/configs/mxs_defconfig |   63 +++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>

-- 
1.7.10.4
