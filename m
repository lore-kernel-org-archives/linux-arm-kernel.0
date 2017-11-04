From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 4 Nov 2017 09:26:19 +0100
Subject: [GIT PULL] ARM: SoC fixes for 4.14
Message-ID: <CAK8P3a0Eb_LWvBtcM-wKCOSGEFk4d9Xp+Sufe67vqrYAJMmjhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0b07194bb55ed836c2cc7c22e866b87a14681984:

  Linux 4.14-rc7 (2017-10-29 13:58:38 -0700)

are available in the git repository at:

  ssh://git at gitolite.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-fixes

for you to fetch changes up to da984d754069818090511fc3b36ea2f9a0b538b5:

  Merge tag 'mvebu-fixes-4.14-3' of
git://git.infradead.org/linux-mvebu into fixes (2017-10-30 15:55:12
+0100)

----------------------------------------------------------------
ARM: SoC fixes for 4.14

Only two patches came in over the last two weeks: Uniphier USB support
needs additional clocks enabled (on both 32-bit and 64-bit ARM), and
a Marvell MVEBU stability issue has been fixed.

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge tag 'uniphier-fixes-v4.14' of
git://git.kernel.org/.../masahiroy/linux-uniphier into fixes
      Merge tag 'mvebu-fixes-4.14-3' of
git://git.infradead.org/linux-mvebu into fixes

Masahiro Yamada (2):
      ARM: dts: uniphier: add STDMAC clock to EHCI nodes
      arm64: dts: uniphier: add STDMAC clock to EHCI nodes

Yan Markman (1):
      ARM: dts: mvebu: pl310-cache disable double-linefill

 arch/arm/boot/dts/armada-375.dtsi                | 4 ++--
 arch/arm/boot/dts/armada-38x.dtsi                | 4 ++--
 arch/arm/boot/dts/armada-39x.dtsi                | 4 ++--
 arch/arm/boot/dts/uniphier-ld4.dtsi              | 9 ++++++---
 arch/arm/boot/dts/uniphier-pro4.dtsi             | 6 ++++--
 arch/arm/boot/dts/uniphier-sld8.dtsi             | 9 ++++++---
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 9 ++++++---
 7 files changed, 28 insertions(+), 17 deletions(-)
