From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 19 Jul 2018 08:01:44 +0900
Subject: [GIT PULL 2/3] arm64: dts: uniphier: UniPhier DT updates for v4.19
Message-ID: <CAK7LNAStvWBsimKG2uBe9ROAU8dAV2Zi6F=6VrOS4pFnQgNhAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull UniPhier DT (64bit) updates for the v4.19 MW.

Thanks!



The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v4.19

for you to fetch changes up to 1470075d5e354da8f46f5aa2e6956de794eb406a:

  arm64: dts: uniphier: add headphone detect gpio for LD11 global
board (2018-07-19 06:43:12 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v4.19

- Add missing #cooling-cells properties

- Add hp-det-gpio property to detect headphone via GPIO

----------------------------------------------------------------
Katsuhiro Suzuki (2):
      arm64: dts: uniphier: add headphone detect gpio for LD20 global board
      arm64: dts: uniphier: add headphone detect gpio for LD11 global board

Viresh Kumar (1):
      arm64: dts: uniphier: Add missing cooling device properties for CPUs

 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 1 +
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 1 +
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 2 ++
 3 files changed, 4 insertions(+)


-- 
Best Regards
Masahiro Yamada
