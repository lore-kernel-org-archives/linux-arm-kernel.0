From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Sat, 29 Sep 2018 16:56:59 +0200
Subject: [GIT PULL] Allwinner arm64 DT changes for 4.20
Message-ID: <20180929145659.73sto3j7235jg6b6@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are our usual set of DT changes for the arm64 SoCs for the next
merge window.

Thanks!
Maxime

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt64-for-4.20

for you to fetch changes up to 679294497be31596e1c9c61507746d72b6b05f26:

  arm64: dts: allwinner: a64: a64-olinuxino: set the PHY TX delay (2018-09-27 18:20:35 +0800)

----------------------------------------------------------------
Allwinner arm64 DT changes for 4.20

Our usual set of DT changes for the arm64 Allwinner SoCs.

The most notable things are:
  - HDMI support on the A64
  - New boards: OrangePi One Plus

----------------------------------------------------------------
Andre Przywara (9):
      arm64: dts: allwinner: a64: Add L2 cache nodes
      arm64: dts: allwinner: a64: Add Pine64-LTS device tree file
      arm64: dts: allwinner: a64: Olinuxino: fix DRAM voltage
      arm64: dts: allwinner: a64: Olinuxino: add Ethernet nodes
      arm64: dts: allwinner: a64: Olinuxino: enable USB
      arm64: dts: allwinner: a64: NanoPi-A64: Fix DCDC1 voltage
      arm64: dts: allwinner: a64: NanoPi-A64: Add Ethernet
      arm64: dts: allwinner: a64: NanoPi-A64: Add Wifi chip
      arm64: dts: allwinner: a64: NanoPi-A64: Add blue status LED

Chen-Yu Tsai (3):
      arm64: dts: allwinner: a64: Split out data strobe pin from mmc2 pinmux
      arm64: dts: allwinner: a64: Rename uart0_pins_a label to uart0_pb_pins
      arm64: dts: allwinner: a64: Rename r_i2c_pins_a label to r_i2c_pl89_pins

Emmanuel Vadot (1):
      arm64: dts: allwinner: a64: Add SID node

Icenowy Zheng (1):
      arm64: dts: allwinner: h6: add system controller device tree node

Jagan Teki (3):
      arm64: dts: allwinner: h6: Add OrangePi One Plus initial support
      arm64: dts: allwinner: a64: Add display pipeline
      arm64: dts: allwinner: a64: Enable HDMI output on A64 boards w/ HDMI

Rodrigo Exterck?tter Tj?der (1):
      arm64: dts: allwinner: a64: a64-olinuxino: set the PHY TX delay

Samuel Holland (9):
      arm64: dts: allwinner: a64: Orange Pi Win: Fix SD card node
      arm64: dts: allwinner: a64: Orange Pi Win: Enable USB hub regulator
      arm64: dts: allwinner: a64: Orange Pi Win: Enable USB OTG socket
      arm64: dts: allwinner: a64: Orange Pi Win: Add Ethernet node
      arm64: dts: allwinner: a64: Orange Pi Win: Add UARTs
      arm64: dts: allwinner: a64: Orange Pi Win: Add LED node
      arm64: dts: allwinner: a64: Orange Pi Win: Add SDIO node
      arm64: dts: allwinner: a64: Orange Pi Win: Add SPI flash node
      arm64: dts: allwinner: a64: Orange Pi Win: Adjust CSI power rails

Tuomas Tynkkynen (1):
      arm64: dts: allwinner: Don't use cd-inverted in sun50i-a64-pinebook

 arch/arm64/boot/dts/allwinner/Makefile             |   2 +
 .../dts/allwinner/sun50i-a64-amarula-relic.dts     |   2 +-
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |  30 +++-
 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   |  85 ++++++++-
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    |  99 ++++++++++-
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 175 ++++++++++++++++++-
 .../boot/dts/allwinner/sun50i-a64-pine64-lts.dts   |  13 ++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  28 ++-
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts     |   9 +-
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  |  28 ++-
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts      |   2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 193 ++++++++++++++++++++-
 .../dts/allwinner/sun50i-h6-orangepi-one-plus.dts  | 150 ++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       |  23 +++
 14 files changed, 812 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180929/59956104/attachment.sig>
