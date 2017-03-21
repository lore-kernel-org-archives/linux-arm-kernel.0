From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 22 Mar 2017 08:59:30 +0900
Subject: [GIT PULL] (REPOST) arm64: dts: uniphier: UniPhier DT updates (64bit)
 for v4.12
Message-ID: <CAK7LNAR5SZH7eR781De80SrSsfczf7vU2Ok+kybYhZ_TXQaqRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,


I forgot to add [GIT PULL] tag,
I am re-sending.  Sorry.


Here are UniPhier DT (64bit) updates for the v4.12 merge window.
Please pull!

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v4.12

for you to fetch changes up to 7a201e31422b208cfedd15c08e9b0442871e2d97:

  arm64: dts: uniphier: re-order reset deassertion of USB of LD11
(2017-03-13 00:32:40 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v4.12

- Fix W=* build warnings
- Add pinctrl properties to eMMC nodes
- Fix resets properties of USB nodes

----------------------------------------------------------------
Masahiro Yamada (4):
      arm64: dts: uniphier: fix no unit name warnings
      arm64: dts: uniphier: move memory node below aliases node
      arm64: dts: uniphier: add pinctrl property to eMMC node for LD11/LD20
      arm64: dts: uniphier: re-order reset deassertion of USB of LD11

 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts | 10 +++++-----
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi    | 13 +++++++++----
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts | 10 +++++-----
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi    |  4 +++-
 4 files changed, 22 insertions(+), 15 deletions(-)

-- 
Best Regards
Masahiro Yamada
