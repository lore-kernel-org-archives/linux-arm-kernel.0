From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Mar 2014 17:16:49 +0100
Subject: [GIT PULL] Allwinner DT additions for 3.15, take 2
Message-ID: <20140313161649.GA10786@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following pull request that comes on top of the previous one.

Thanks!

Maxime

The following changes since commit 225b02163cd51b6d5ebef4d2e19a09345f2ee3a5:

  ARM: sun6i: dt: Fix mod0 compatible (2014-02-28 12:04:53 +0100)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-dt-for-3.15-2

for you to fetch changes up to ca5d04d90825a3f3f2fc1aaba09953a55564e0e8:

  ARM: sunxi: dt: Update the watchdog compatibles (2014-03-13 11:28:34 +0100)

----------------------------------------------------------------
Allwinner DT additions for 3.15, take 2:
  - Two new boards: INet 97F Rev 02 and A10-OLinuXino-LIME
  - Addition of the I2C for the A31
  - Addition USB Host mode for the A10, A10s, A13 and A20
  - Addition of SATA support for the A10 and A20
  - Change of compatible for the watchdog

----------------------------------------------------------------
David Lanzend?rfer (1):
      ARM: sun4i: dt: Add support for the INet-97F_Rev_02 board

Hans de Goede (9):
      ARM: sunxi: dt: Add sunxi-common-regulators include file
      ARM: sun7i: dt: Add ahci / sata support
      ARM: sun4i: dt: Add USB host nodes to hackberry dts
      ARM: sun4i: dt: Add USB host nodes to mini-xplus dts
      ARM: sun4i: dt: Add USB host nodes to pcduino.dts
      ARM: sun5i: dt: Add USB host nodes to a10s-olinuxino-micro
      ARM: sun5i: dt: Add USB host nodes to a13-olinuxino-micro
      ARM: sun7i: dt: Add USB host nodes to cubietruck dts
      ARM: sun4i: dt: Add support for the A10-OLinuXino-LIME board

Maxime Ripard (4):
      ARM: sun6i: Enable the I2C controllers
      ARM: sun6i: Enable the I2C muxing options
      ARM: sun6i: colombus: Enable the I2C controllers
      ARM: sunxi: dt: Update the watchdog compatibles

Oliver Schinagl (1):
      ARM: sun4i: dt: Add ahci / sata support

Roman Byshko (7):
      ARM: sun4i: dt: Add USB host bindings
      ARM: sun5i: dt: Add USB host bindings
      ARM: sun7i: dt: Add USB host bindings
      ARM: sun4i: dt: Add USB host nodes to Mele A1000 dts
      ARM: sun4i: dt: Add USB host nodes to cubieboard dts
      ARM: sun5i: dt: Add USB host nodes to A13-Olinuxino
      ARM: sun7i: dt: Add USB host nodes to cubieboard2 dts

Zalan Blenessy (1):
      ARM: sun7i: dt: Add USB host nodes to a20-olinuxino-micro dts

 arch/arm/boot/dts/Makefile                       |   2 +
 arch/arm/boot/dts/sun4i-a10-a1000.dts            |  35 +++++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       |  40 ++++++++
 arch/arm/boot/dts/sun4i-a10-hackberry.dts        |  40 ++++++++
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts        |  69 ++++++++++++++
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts       |  31 +++++++
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts   | 111 +++++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10-pcduino.dts          |  31 +++++++
 arch/arm/boot/dts/sun4i-a10.dtsi                 |  62 ++++++++++++-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  27 ++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  34 ++++++-
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  |  27 ++++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        |  27 ++++++
 arch/arm/boot/dts/sun5i-a13.dtsi                 |  34 ++++++-
 arch/arm/boot/dts/sun6i-a31-colombus.dts         |  18 ++++
 arch/arm/boot/dts/sun6i-a31.dtsi                 |  63 ++++++++++++-
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      |  40 ++++++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts       |  49 ++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  |  40 ++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                 |  62 ++++++++++++-
 arch/arm/boot/dts/sunxi-common-regulators.dtsi   |  75 +++++++++++++++
 21 files changed, 912 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
 create mode 100644 arch/arm/boot/dts/sunxi-common-regulators.dtsi

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140313/eadb174c/attachment.sig>
