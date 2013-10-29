From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Oct 2013 16:09:38 -0700
Subject: [GIT PULL] omap dt fixes for v3.13 merge window
Message-ID: <pull-1383088178-786762>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b4887e16375be312cf64642ac1d826186cb836bf:

  Merge tag 'for_3.13_super_late/dts_signed' of git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt into omap-for-v3.13/dt (2013-10-23 03:12:45 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/dt-fixes-for-merge-window

for you to fetch changes up to 0352bd1f04b706904b26d13f6d8792e7ff6b7eb6:

  ARM: dts: omap4-panda: add DPI pinmuxing (2013-10-29 14:24:34 -0700)

----------------------------------------------------------------
Few device tree changes that fix boot time warnings and
make panda display work with recent u-boot.

----------------------------------------------------------------
Lokesh Vutla (1):
      ARM: dts: AM33xx: Add RNG node

Suman Anna (3):
      ARM: dts: OMAP4: Add hwspinlock node
      ARM: dts: OMAP5: Add hwspinlock node
      ARM: dts: AM33XX: Add hwspinlock node

Tomi Valkeinen (1):
      ARM: dts: omap4-panda: add DPI pinmuxing

 .../devicetree/bindings/hwrng/omap_rng.txt         | 22 +++++++++++
 arch/arm/boot/dts/am33xx.dtsi                      | 13 +++++++
 arch/arm/boot/dts/omap4-panda-common.dtsi          | 43 ++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |  6 +++
 arch/arm/boot/dts/omap5.dtsi                       |  6 +++
 5 files changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwrng/omap_rng.txt
