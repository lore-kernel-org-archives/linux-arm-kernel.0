From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Oct 2017 02:40:51 +0900
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates (64bit) for v4.15
Message-ID: <CAK7LNARKAivEyNYDMO7GKjTnnsVFk3TtsCZ_yDWLrEf80G-WOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are UniPhier DT (64bit) updates for the v4.15 merge window.
Please pull!



The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v4.15

for you to fetch changes up to 76c48e1ecaf34eccaf1bddc462159e82be3d609a:

  arm64: dts: uniphier: add resets properties (2017-10-24 02:12:57 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v4.15

- add thermal monitor and thermal zone nodes
- add efuse nodes
- fix W=2 warnings
- add GPIO controller nodes and related properties
- add resets properties

----------------------------------------------------------------
Keiji Hayashibara (1):
      arm64: dts: uniphier: add efuse node for LD11, LD20, and PXs3

Kunihiko Hayashi (1):
      arm64: dts: uniphier: add nodes of thermal monitor and thermal
zone for LD20

Masahiro Yamada (7):
      arm64: dts: uniphier: enable NAND for PXs3 reference board
      arm64: dts: uniphier: fix W=2 build warnings
      arm64: dts: uniphier: add GPIO controller nodes
      arm64: dts: uniphier: route on-board device IRQ to GPIO controller
      arm64: dts: uniphier: add GPIO hog definition
      arm64: dts: uniphier: add eMMC hardware reset provider node
      arm64: dts: uniphier: add resets properties

 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts |  11 ++-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi    |  65 ++++++++++++-
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts |  11 ++-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi    | 105 ++++++++++++++++++++-
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |   4 +
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi    |  58 +++++++++++-
 6 files changed, 248 insertions(+), 6 deletions(-)


-- 
Best Regards
Masahiro Yamada
