From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 22 Jan 2013 18:50:40 +0100
Subject: [PATCH 0/6] at91: some fixes for 3.8-rc5
Message-ID: <cover.1358876553.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I try to collect fixes for AT91 that can be applied during this development
cycle. Please tell me now if you have more to queue or if some of the proposed
fixes are not targetted to v3.8-final in you opinion...

Thanks, cheers,


Boris BREZILLON (1):
  ARM: at91/dts: add macb mii pinctrl config for kizbox

Jean-Christophe PLAGNIOL-VILLARD (1):
  ARM: at91: rm9200: remake the BGA as default version

Joachim Eastwood (1):
  ARM: at91: fix gpios on i2c-gpio for RM9200 DT

Richard Genoud (3):
  ARM: at91/at91-pinctrl documentation: fix typo and add some details
  ARM: at91/at91sam9x5 DTS: correct wrong PIO BANK values on u(s)arts
  ARM: at91/at91sam9x5 DTS: add SCK USART pins

 .../bindings/pinctrl/atmel,at91-pinctrl.txt        |  5 ++-
 arch/arm/boot/dts/at91rm9200.dtsi                  |  4 +-
 arch/arm/boot/dts/at91sam9x5.dtsi                  | 44 ++++++++++++++++------
 arch/arm/boot/dts/kizbox.dts                       |  2 +
 arch/arm/mach-at91/setup.c                         |  2 +
 5 files changed, 41 insertions(+), 16 deletions(-)

-- 
1.8.0
