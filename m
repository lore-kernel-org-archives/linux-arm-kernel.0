From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 16 Aug 2017 12:01:01 +0900
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates (64bit) for v4.14
Message-ID: <CAK7LNARP=6+63Cnjy-U57-0_Ue-5FamM-9SdBtfxkfmqHesxjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are UniPhier DT (64bit) updates for the v4.14 merge window.
Please pull!


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v4.14

for you to fetch changes up to e5aefb380eafe176de066ddde1d354a167a9d474:

  arm64: dts: uniphier: add Denali NAND controller nodes (2017-08-13
08:43:27 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v4.14

- add nodes for NAND, Watchdog
- replace /include/ with #include
- use #include <arm/...> instead of symlinks

----------------------------------------------------------------
Keiji Hayashibara (1):
      arm64: dts: uniphier: add watchdog node for LD11 and LD20

Masahiro Yamada (3):
      arm64: dts: uniphier: use #include instead of /include/
      arm64: dts: uniphier: use cross-arch include instead of symlinks
      arm64: dts: uniphier: add Denali NAND controller nodes

 .../boot/dts/socionext/uniphier-ld11-global.dts  |  6 +++++-
 .../boot/dts/socionext/uniphier-ld11-ref.dts     |  6 +++---
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 17 ++++++++++++++++-
 .../boot/dts/socionext/uniphier-ld20-global.dts  |  6 +++++-
 .../boot/dts/socionext/uniphier-ld20-ref.dts     |  6 +++---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 17 ++++++++++++++++-
 .../boot/dts/socionext/uniphier-pinctrl.dtsi     |  2 +-
 .../dts/socionext/uniphier-ref-daughter.dtsi     |  2 +-
 .../dts/socionext/uniphier-support-card.dtsi     |  2 +-
 9 files changed, 51 insertions(+), 13 deletions(-)
 mode change 120000 => 100644
arch/arm64/boot/dts/socionext/uniphier-pinctrl.dtsi
 mode change 120000 => 100644
arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi
 mode change 120000 => 100644
arch/arm64/boot/dts/socionext/uniphier-support-card.dtsi


-- 
Best Regards
Masahiro Yamada
