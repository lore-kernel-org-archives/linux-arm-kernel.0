From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 29 Dec 2017 22:35:38 +0900
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates (64bit) for v4.16
Message-ID: <CAK7LNAR+RgxHGa8ZgVUsUbJAeaQqvm-mh=Xrss-JHsDNM79t_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are UniPhier DT (64bit) updates for the v4.16 merge window.
Please pull!


The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v4.16

for you to fetch changes up to dbdae8474e08fc1194102bef95dc96db435c15da:

  arm64: dts: uniphier: enable more serial ports for PXs3 ref board
(2017-12-29 22:03:26 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v4.16

- clean up gpios properties by macro
- add GPIO hog for PXs3 reference node
- add has-transaction-translator property to generic-ehci nodes
- enable more serial ports for PXs3 reference node

----------------------------------------------------------------
Kunihiko Hayashi (1):
      arm64: dts: uniphier: add has-transaction-translator property to
usb node for LD11

Masahiro Yamada (3):
      arm64: dts: uniphier: use macros in dt-bindings header
      arm64: dts: uniphier: add GPIO hog definition for PXs3
      arm64: dts: uniphier: enable more serial ports for PXs3 ref board

 .../boot/dts/socionext/uniphier-ld11-ref.dts    |  2 +-
 .../arm64/boot/dts/socionext/uniphier-ld11.dtsi |  6 +++++-
 .../boot/dts/socionext/uniphier-ld20-ref.dts    |  2 +-
 .../arm64/boot/dts/socionext/uniphier-ld20.dtsi |  3 ++-
 .../boot/dts/socionext/uniphier-pxs3-ref.dts    | 16 ++++++++++++++++
 .../arm64/boot/dts/socionext/uniphier-pxs3.dtsi |  3 ++-
 6 files changed, 27 insertions(+), 5 deletions(-)



-- 
Best Regards
Masahiro Yamada
