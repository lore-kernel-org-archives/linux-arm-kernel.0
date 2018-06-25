From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 25 Jun 2018 23:13:04 +0900
Subject: [GIT PULL] ARM: uniphier: fixes for v4.18
Message-ID: <CAK7LNARAMcUgV2K1_dDdkupaWdtLqGMz==+huurHJKyW=JVWxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull some fixes of ARM UniPhier platform.



The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-fixes-v4.18

for you to fetch changes up to 4e62893c25bd3d5758058e15958364df3ca15fbc:

  arm64: uniphier: select RESET_CONTROLLER (2018-06-25 23:00:31 +0900)

----------------------------------------------------------------
UniPhier ARM SoC fixes for v4.18

 - add missing cooling device properties for CPUS

 - fix widget name of headphone

 - select RESET_CONTROLLER

----------------------------------------------------------------
Katsuhiro Suzuki (1):
      arm64: dts: uniphier: fix widget name of headphone for LD11/LD20 boards

Masahiro Yamada (2):
      ARM: uniphier: select RESET_CONTROLLER
      arm64: uniphier: select RESET_CONTROLLER

Viresh Kumar (2):
      ARM: dts: uniphier: Add missing cooling device properties for CPUs
      arm64: dts: uniphier: Add missing cooling device properties for CPUs

 arch/arm/boot/dts/uniphier-pxs2.dtsi                   | 3 +++
 arch/arm/mach-uniphier/Kconfig                         | 1 +
 arch/arm64/Kconfig.platforms                           | 1 +
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 2 ++
 6 files changed, 9 insertions(+), 2 deletions(-)


-- 
Best Regards
Masahiro Yamada
