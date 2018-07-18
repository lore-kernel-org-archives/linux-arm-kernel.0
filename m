From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 19 Jul 2018 08:05:03 +0900
Subject: [GIT PULL 3/3] ARM: uniphier: UniPhier SoC updates for v4.19
Message-ID: <CAK7LNAShLhWqCRR8RfuJ0xBJAFoj-S6WLcSdh9QShg8dGfq9RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull UniPhier SoC changes for the v4.19 MW.

Thanks!


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-soc-v4.19

for you to fetch changes up to ae93e694440a454609fa40725e16619c5a781768:

  ARM: uniphier: remove empty Makefile (2018-07-19 06:53:16 +0900)

----------------------------------------------------------------
UniPhier ARM SoC updates for v4.19

- enable ethernet and thermal drivers from multi_v7_defconfig

- select RESET_CONTROLLER

- remove empty arch/arm/mach-uniphier/Makefile

----------------------------------------------------------------
Kunihiko Hayashi (1):
      ARM: multi_v7_defconfig: add CONFIG_UNIPHIER_THERMAL and CONFIG_SNI_AVE

Masahiro Yamada (3):
      ARM: uniphier: select RESET_CONTROLLER
      arm64: uniphier: select RESET_CONTROLLER
      ARM: uniphier: remove empty Makefile

 arch/arm/Makefile                   | 1 -
 arch/arm/configs/multi_v7_defconfig | 2 ++
 arch/arm/mach-uniphier/Kconfig      | 1 +
 arch/arm/mach-uniphier/Makefile     | 0
 arch/arm64/Kconfig.platforms        | 1 +
 5 files changed, 4 insertions(+), 1 deletion(-)
 delete mode 100644 arch/arm/mach-uniphier/Makefile


-- 
Best Regards
Masahiro Yamada
