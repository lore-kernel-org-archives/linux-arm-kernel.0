From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 May 2018 11:33:07 +0200
Subject: [GIT PULL] Ux500 DTS changes for v4.18
Message-ID: <CACRpkdYR_eUXMGArMwCChKBdTSUCt4pd0+ofGCQ0sLmN8kCCMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there ARM SoC folks,

here is two DTS update patches for Ux500 for v4.18.
We fix up the debounces and delete the unused U8540
and U9540 device trees.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-dts-arm-soc

for you to fetch changes up to f6601ae15fffbb3ade2cdbace9a2c9a25aba85ea:

  ARM: ux500: Drop the U8540 device trees (2018-05-04 11:15:43 +0200)

----------------------------------------------------------------
This:
- Corrects the debounce interval on some nodes
- Drops the U8540/U9540 device trees

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: dts: Ux500: Fix "debounce-interval" property misspelling

Linus Walleij (1):
      ARM: ux500: Drop the U8540 device trees

 arch/arm/boot/dts/Makefile                 |   4 +-
 arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi | 196 -----------------------------
 arch/arm/boot/dts/ste-ccu8540.dts          |  94 --------------
 arch/arm/boot/dts/ste-ccu9540.dts          |  79 ------------
 arch/arm/boot/dts/ste-snowball.dts         |  10 +-
 5 files changed, 6 insertions(+), 377 deletions(-)
 delete mode 100644 arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/ste-ccu8540.dts
 delete mode 100644 arch/arm/boot/dts/ste-ccu9540.dts
