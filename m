From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 6 Nov 2012 14:14:56 +0100
Subject: [PATCH 0/9] Ux500 pinctrl table updates
Message-ID: <1352207696-7778-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

So until we have device tree support for the pinctrl mapping table
we need to manage this in a consistent manner. The following patch
series reflect the internal ST-Ericsson development to migrate
our codebase over to use the pinctrl subsystem.

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

-- 
1.7.11.3
