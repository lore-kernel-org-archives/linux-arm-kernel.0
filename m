From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 20 May 2018 11:38:39 +0900
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v4.18
Message-ID: <CAK7LNASUq_9osPdzbiMCbYzeqc=W3Yv7tB63V+5gXqcZ9QBtYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are UniPhier DT (64bit) updates for the v4.18 merge window.
Please pull!


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v4.18

for you to fetch changes up to b076ff8bddfba793d49bca14feb49a0e84f41843:

  arm64: dts: uniphier: add syscon-phy-mode property to each ethernet
node (2018-04-25 00:21:14 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v4.18

- add more properties to ethernet nodes

----------------------------------------------------------------
Kunihiko Hayashi (2):
      arm64: dts: uniphier: add clock-names and reset-names to ethernet node
      arm64: dts: uniphier: add syscon-phy-mode property to each ethernet node

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 5 ++++-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 3 +++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 8 +++++++-
 3 files changed, 14 insertions(+), 2 deletions(-)


-- 
Best Regards
Masahiro Yamada
