From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 May 2014 23:07:05 +0200
Subject: [GIT PULL] Allwinner DT changes for 3.16, take 2
Message-ID: <20140523210705.GA18960@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here is the last set of Allwinner DT changes for the 3.16 merge window.

It comes on top of the previous pull request.

Thanks!
Maxime

The following changes since commit 209394aed532c5de9bf549f4beac92bf1b80f887:

  ARM: sunxi: dt: declare the r_pio pin controller for A31 SoC (2014-05-15 10:38:00 +0200)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-dt-for-3.16-2

for you to fetch changes up to c690d80b82d96f32b8880a5d0b84a3d8509b17eb:

  ARM: dts: sun7i: Add new i12-tvbox board (2014-05-22 11:35:07 +0200)

----------------------------------------------------------------
Allwinner DT changes for 3.16, take 2

  - Introduction of a new board, the i12-tvbox
  - Enable the MMC and USB controllers on the Colombus
  - Add the enable-method to the A31 cpus
  - a few fixes

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: sunxi: dt: build DTs according to new MACH_SUNxI Kconfig symbols

Hans de Goede (2):
      ARM: dts: sun7i: cubietruck: set mmc3 bus-width property
      ARM: dts: sun7i: Add new i12-tvbox board

Maxime Ripard (5):
      ARM: sun6i: Define the A31 CPUs enable-method
      ARM: sunxi: Add fixed 3V regulator
      ARM: sun6i: Enable USB Host support on the Colombus board
      ARM: sun6i: Fix OHCI2 node name
      ARM: sun6i: Add MMC0 controller to the Colombus board

 arch/arm/boot/dts/Makefile                     |  12 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts       |  47 +++++++
 arch/arm/boot/dts/sun6i-a31.dtsi               |   3 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts     |   1 +
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts      | 176 +++++++++++++++++++++++++
 arch/arm/boot/dts/sunxi-common-regulators.dtsi |   7 +
 6 files changed, 241 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140523/71f8354f/attachment.sig>
