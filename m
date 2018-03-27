From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 28 Mar 2018 01:31:15 +0900
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for 4.17 (2nd)
Message-ID: <CAK7LNAQWikF9K41uzkQjixUEO=_s14txEhvd=rmLY69JShezKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Sorry for this very late pull request.
If possible, could you pull a little more for v4.17-rc1 ?



The following changes since commit 7f9f76b10dbe3f2585a21699312f74ed2b544b84:

  ARM: dts: uniphier: add sound node for PXs2 (2018-03-15 23:19:05 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.17-2

for you to fetch changes up to aba054a1cd45d87ce473fea6cabbf4b2dc677569:

  arm64: dts: uniphier: add ethernet node for PXs3 (2018-03-28 01:16:18 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.17 (2nd)

- add syscon property to sound nodes
- add more ethernet pin groups
- add ethernet support for PXs3 SoC

----------------------------------------------------------------
Katsuhiro Suzuki (2):
      arm64: dts: uniphier: add syscon property for UniPhier sound system
      ARM: dts: uniphier: add syscon property for UniPhier sound system

Kunihiko Hayashi (2):
      ARM: dts: uniphier: add pinctrl groups of ethernet for second instance
      arm64: dts: uniphier: add ethernet node for PXs3

 arch/arm/boot/dts/uniphier-pinctrl.dtsi            | 10 ++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |  3 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |  3 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |  3 +-
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts | 22 +++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   | 36 ++++++++++++++++++++++
 6 files changed, 74 insertions(+), 3 deletions(-)


-- 
Best Regards
Masahiro Yamada
