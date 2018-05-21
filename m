From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 21 May 2018 13:45:58 +0200
Subject: [GIT PULL] Allwinner arm64 changes for 4.18
Message-ID: <20180521114558.ozkb4ftf4p56ov7c@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is our bunch of arm64 DT changes for the next merge window.

Thanks!
Maxime

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt64-for-4.18

for you to fetch changes up to 17ebc33afc35094f779ddca92ffcbda800365574:

  arm64: allwinner: h6: add PCF8563 RTC on Pine H64 board (2018-05-04 17:12:13 +0200)

----------------------------------------------------------------
Allwinner arm64 changes for 4.18

We mostly have some changes to support the H6, Allwinner latest SoC. We're
still in the preliminary phase, with I2C, pinctrl and clock support.

----------------------------------------------------------------
Icenowy Zheng (6):
      arm64: allwinner: h6: restore the usage of CCU slice macros
      arm64: allwinner: h6: add PRCM CCU device node
      arm64: allwinner: h6: add node for R_PIO pin controller
      arm64: allwinner: h6: add R_INTC interrupt controller
      arm64: allwinner: h6: add R_I2C controller
      arm64: allwinner: h6: add PCF8563 RTC on Pine H64 board

Jagan Teki (2):
      arm64: dts: allwinner: axp803: Add drivevbus regulator
      arm64: dts: allwinner: a64: bananapi-m64: add usb otg

 arch/arm64/boot/dts/allwinner/axp803.dtsi          |  5 ++
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 21 +++++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      | 10 ++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       | 70 +++++++++++++++++++---
 4 files changed, 97 insertions(+), 9 deletions(-)

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180521/b21ded97/attachment.sig>
