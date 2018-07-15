From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 15 Jul 2018 12:03:33 +0200
Subject: [GIT PULL] Ux500 DTS changes for v4.19
Message-ID: <CACRpkdboWGC5Q1WXQt6u4E3tW+kObCFqtL6eBDoQR=PNz_S91g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here are some Ux500 DTS changes that have stacked up.
Please pull them in for v4.19!

Yours,
Linus Walleij

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-dts-v4.19

for you to fetch changes up to 97ac567429605c931223a40cae7f2c24f5ae809f:

  ARM: dts: ux500: Get rid of DTC warnings (2018-07-15 11:57:30 +0200)

----------------------------------------------------------------
Ux500 DTS changes for the v4.19 series.
Mostly cleanups and fixes, got rid of the DTC warnings.

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: dts: ux500: Correct SCU unit address
      dt-bindings: arm: scu: Correct example SCU unit addresses

Linus Walleij (2):
      ARM: dts: ux500: Fix LCDA clock line muxing
      ARM: dts: ux500: Get rid of DTC warnings

 Documentation/devicetree/bindings/arm/scu.txt          | 2 +-
 Documentation/devicetree/bindings/arm/ux500/boards.txt | 2 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi                      | 9 +++++++--
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi         | 8 ++++++--
 arch/arm/boot/dts/ste-href.dtsi                        | 1 +
 arch/arm/boot/dts/ste-snowball.dts                     | 1 +
 6 files changed, 17 insertions(+), 6 deletions(-)
