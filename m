From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Sat, 29 Sep 2018 16:52:16 +0200
Subject: [GIT PULL] Allwinner DT changes for 4.20
Message-ID: <20180929145216.bq52nv6bkjn265xc@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is our usual set of changes for the next merge window.

Thanks!
Maxime

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-4.20

for you to fetch changes up to 57a83c5222c1b5e7b3acc72c6e60fce00a38991a:

  ARM: dts: sun9i: Fix I2C bus warnings (2018-09-14 16:59:24 +0800)

----------------------------------------------------------------
Allwinner DT changes for 4.20

Our usual bunch of DT patches for the Allwinner arm32 SoCs.

The most notable changes are:
  - Support for the video decoding / encoding engine on the
    A10s/A13/A20/A33
  - IR support for the A83t
  - SATA support for the R40

----------------------------------------------------------------
Corentin Labbe (2):
      ARM: dts: sun8i: r40: add sata node
      ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI

Paul Kocialkowski (3):
      ARM: dts: sun5i: Add Video Engine and reserved memory nodes
      ARM: dts: sun7i-a20: Add Video Engine and reserved memory nodes
      ARM: dts: sun8i-a33: Add Video Engine and reserved memory nodes

Philipp Rossak (3):
      ARM: dts: sun8i: a83t: Add the cir pin for the A83T
      ARM: dts: sun8i: a83t: Add support for the cir interface
      ARM: dts: sun8i: a83t: bananapi-m3: Enable IR controller

Rob Herring (2):
      ARM: dts: sunxi: Fix I2C bus warnings
      ARM: dts: sun9i: Fix I2C bus warnings

Tuomas Tynkkynen (1):
      ARM: dts: sunxi: Don't use cd-inverted in sun8i-r40-bananapi-m2-ultra

 .../boot/dts/sun5i-reference-design-tablet.dtsi    |  3 ++-
 arch/arm/boot/dts/sun5i.dtsi                       | 26 ++++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                   | 26 ++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-a33.dtsi                   | 26 ++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       |  5 +++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 18 +++++++++++++++
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 21 +++++++++++++++--
 arch/arm/boot/dts/sun8i-r40.dtsi                   | 13 +++++++++++
 .../boot/dts/sun8i-reference-design-tablet.dtsi    |  3 ++-
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts  |  2 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                   |  2 +-
 11 files changed, 139 insertions(+), 6 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180929/7dcfe6d8/attachment-0001.sig>
