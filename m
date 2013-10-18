From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Oct 2013 19:14:56 +0200
Subject: [GIT PULL] Allwinner sunXi core additions for 3.13
Message-ID: <20131018171456.GA14419@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin, Olof,

Please pull the following changes for the 3.13 merge window.

Thanks!
Maxime

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-core-for-3.13

for you to fetch changes up to fc42ef5121687d917bbdd96805fb70c28a2ad023:

  Documentation: dt: Remove clock gates IDs list for Allwinner SoCs (2013-10-11 21:24:46 +0200)

----------------------------------------------------------------
Allwinner sunXi SoCs machine additions for 3.13

Nothing outstanding here, mostly some documentation cleanup, and the split of
the previous generic machine declaration into three different machines to
handle the sun4i/sun5i, sun6i and sun7i separately.

----------------------------------------------------------------
Maxime Ripard (7):
      ARM: sunxi: Split out the DT machines for sun6i and sun7i
      ARM: sunxi: Simplify restart setup code
      ARM: sunxi: Order Kconfig options alphabetically
      Documentation: sunxi: Update A13 user manual dead link
      Documentation: sunxi: Update Allwinner SoC documentation
      Documentation: dt: Remove interrupt sources list for Allwinner SoCs
      Documentation: dt: Remove clock gates IDs list for Allwinner SoCs

 Documentation/arm/sunxi/README                     | 26 +++++-
 Documentation/devicetree/bindings/clock/sunxi.txt  |  4 +-
 .../bindings/clock/sunxi/sun4i-a10-gates.txt       | 93 --------------------
 .../bindings/clock/sunxi/sun5i-a10s-gates.txt      | 75 -----------------
 .../bindings/clock/sunxi/sun5i-a13-gates.txt       | 58 -------------
 .../bindings/clock/sunxi/sun6i-a31-gates.txt       | 83 ------------------
 .../bindings/clock/sunxi/sun7i-a20-gates.txt       | 98 ----------------------
 .../interrupt-controller/allwinner,sun4i-ic.txt    |  3 -
 .../interrupt-controller/sunxi/sun4i-a10.txt       | 89 --------------------
 .../interrupt-controller/sunxi/sun5i-a13.txt       | 55 ------------
 arch/arm/mach-sunxi/Kconfig                        |  6 +-
 arch/arm/mach-sunxi/sunxi.c                        | 37 +++++---
 12 files changed, 57 insertions(+), 570 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun4i-a10-gates.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun5i-a10s-gates.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun5i-a13-gates.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun6i-a31-gates.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun7i-a20-gates.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunxi/sun4i-a10.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunxi/sun5i-a13.txt

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131018/6a5d21a8/attachment.sig>
