From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 Aug 2013 22:14:22 +0200
Subject: [GIT PULL] Allwinner sunXi DT additions for 3.12, take 3
Message-ID: <20130822201422.GA3042@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following pull request on top of the one I sent
previously for this merge window.

The following changes since commit e476ac8b483de4ce1d8570509be343afc7cd3baf:

  ARM: sun7i: Add Olimex A20-Olinuxino-Micro support (2013-08-20 08:18:45 +0200)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-dt-for-3.12-3

for you to fetch changes up to 82abe5294aeadc42508c7944f3a9aec0eece214c:

  ARM: sun7i: Add Cubieboard2 Device Tree (2013-08-22 00:19:19 +0200)

----------------------------------------------------------------
Third round of patches for the Allwinner SoCs DT

These patches add support for:
  - The cubieboard2 board
  - The pinctrl driver that got merged for the A20 and A31
  - The associated muxing for the A20 and A31 boards already supported

----------------------------------------------------------------
Maxime Ripard (8):
      ARM: sunxi: dt: Add PIO controller to A31 DTSI
      ARM: sun6i: Add UART0 muxing options
      ARM: sun6i: colombus: Add uart0 muxing
      ARM: sun7i: Add the PIO controller node to the DTSI
      ARM: sun7i: DT: Add UART muxing options to the DTSI
      ARM: sun7i: a20-olinuxino: Enable UARTs muxing
      ARM: sun7i: a20-olinuxino: Enable the user LED
      ARM: sun7i: Add Cubieboard2 Device Tree

 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/sun6i-a31-colombus.dts        |  2 +
 arch/arm/boot/dts/sun6i-a31.dtsi                | 19 +++++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 53 +++++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 27 +++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                | 33 +++++++++++++++
 6 files changed, 135 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts

Thanks!
Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130822/31337bfa/attachment.sig>
