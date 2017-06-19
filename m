From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 23:40:38 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20170619064038.GA26844@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 151d1d752bb681f29898c68c966f6e17b446456c:

  MAINTAINERS: EP93XX: Update maintainership (2017-06-06 21:07:37 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to a1858df975edf6706e7a5a3ae000e52d81076807:

  Merge tag 'sunxi-fixes-for-4.12' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into fixes (2017-06-18 20:42:21 -0700)

----------------------------------------------------------------
ARM: SoC fixes

Stream of fixes has slowed down, only a few this week:

 - Some DT fixes for Allwinner platforms, and addition of a clock to
   the R_CCU clock controller that had been missed.
 - A couple of small DT fixes for am335x-sl50.

----------------------------------------------------------------
Chen-Yu Tsai (2):
      ARM: sunxi: h3-h5: Add PLL_PERIPH0 clock to the R_CCU
      arm64: allwinner: a64: Add PLL_PERIPH0 clock to the R_CCU

Enric Balletbo i Serra (2):
      ARM: dts: am335x-sl50: Fix card detect pin for mmc1
      ARM: dts: am335x-sl50: Fix cannot claim requested pins for spi0

Icenowy Zheng (1):
      ARM: sunxi: h3/h5: fix the compatible of R_CCU

Maxime Ripard (1):
      arm64: allwinner: h5: Remove syslink to shared DTSI

Olof Johansson (2):
      Merge tag 'omap-for-v4.12/fixes-sl50' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'sunxi-fixes-for-4.12' of https://git.kernel.org/.../sunxi/linux into fixes

 arch/arm/boot/dts/am335x-sl50.dts              | 8 ++------
 arch/arm/boot/dts/sunxi-h3-h5.dtsi             | 7 ++++---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi  | 5 +++--
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi   | 2 +-
 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi | 1 -
 5 files changed, 10 insertions(+), 13 deletions(-)
 delete mode 120000 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi
