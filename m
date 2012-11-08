From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Nov 2012 09:28:55 +0100
Subject: [GIT PULL] Ux500 pin changes
Message-ID: <CACRpkdYjEmQRU530N3sP7t_RfM_NLhEcMf6YCBdf4LC7M7fQDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

here is a set of pinctrl table patches all just hitting one and the same ux500
file. Description in the signed tag, intended for v3.8.

Please pull them in!

Yours,
Linus Walleij


The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-pins-for-arm-soc

for you to fetch changes up to d792aebfa2daeb58ac6a669ce328ad05e9e4112c:

  ARM: ux500: fixup magnetometer pins (2012-11-06 11:10:55 +0100)

----------------------------------------------------------------
Ux500 pinctrl table update for v3.8, basically accumulated
updates to pin muxing and biasing from internal deployment
and regression testing for power performance.

----------------------------------------------------------------
Jean-Nicolas Graux (1):
      ARM: ux500: add STM pin configuration

Jorgen Jonsson (1):
      ARM: ux500: fixup magnetometer pins

Linus Walleij (1):
      ARM: ux500: delete duplicate macro

Patrice Chotard (6):
      ARM: ux500: 8500: register LCD VSI pinctrl table
      ARM: ux500: 8500: add IDLE pin configuration for SPI
      ARM: ux500: 8500: update SKE keypad pinctrl table
      ARM: ux500: 8500: define SDI sleep states
      ARM: ux500: cosmetic fixups for uart0
      ARM: ux500: 8500: add pinctrl support for uart1 and uart2

 arch/arm/mach-ux500/board-mop500-pins.c | 427 +++++++++++++++++++++++++++-----
 1 file changed, 362 insertions(+), 65 deletions(-)
