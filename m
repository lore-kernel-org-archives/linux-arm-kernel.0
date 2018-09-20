From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Sep 2018 15:11:42 -0700
Subject: [GIT PULL] ux500 DTS changes for v4.20
Message-ID: <CACRpkdaS6rD4CxReRsRZnoJ1bBRRKCcqAnvYUHAFX7Bxox5Qgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here is a bunch of assorted Ux500 DTS patches I have collected
for v4.20. Better get it to linux-next, please pull it into ARM SoC
at some appropriate place!

Yours,
Linus Walleij

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-dts-arm-soc

for you to fetch changes up to 3be9349f38c7dd7f108a71f640908a727101d2db:

  ARM: dts: ux500: Mark PRCMU as syscon compatible (2018-09-20 15:03:25 -0700)

----------------------------------------------------------------
Ux500 DTS changes for the v4.20 kernel cycle.
Assorted housekeeping DTS patches.

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: dts: ux500: Correct SCU unit address
      dt-bindings: arm: scu: Correct example SCU unit addresses

Linus Walleij (3):
      ARM: dts: ux500: Fix LCDA clock line muxing
      ARM: dts: ux500: Get rid of DTC warnings
      ARM: dts: ux500: Mark PRCMU as syscon compatible

Rob Herring (1):
      ARM: dts: ste: Fix SPI controller node names

Suzuki K Poulose (1):
      arm: dts: ste: Update coresight bindings for hardware port

 Documentation/devicetree/bindings/arm/scu.txt      |  2 +-
 .../devicetree/bindings/arm/ux500/boards.txt       |  2 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  | 80 ++++++++++++----------
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi     |  8 ++-
 arch/arm/boot/dts/ste-href.dtsi                    |  1 +
 arch/arm/boot/dts/ste-hrefprev60.dtsi              |  2 +-
 arch/arm/boot/dts/ste-snowball.dts                 |  3 +-
 arch/arm/boot/dts/ste-u300.dts                     |  2 +-
 8 files changed, 56 insertions(+), 44 deletions(-)
