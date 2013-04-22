From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 22 Apr 2013 11:49:01 +0200
Subject: [GIT PULL] at91: DT changes for 3.11 #1 (or 3.10 #4)
Message-ID: <1366624141-32477-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This is an early AT91 Device Tree pull-request for 3.11 (or late for 3.10 ;-)).
Feel free to take it now, delay it or simply tell me to re-send this
pull-request later! I do not want to bother you with these patches as they
certainly can wait and are pretty simple and harmless.

They should be stacked on top of arm-soc/at91/dt3 and are merging seamlessly
with other at91 branches.

Thanks, best regards,

The following changes since commit f10491fff07dcced77f8ab1b3bc1f8e18715bfb9:

  ARM: at91/at91sam9260.dtsi: fix u(s)art pinctrl encoding (2013-04-04 18:31:17 +0200)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-dt

for you to fetch changes up to 2e6faf10411968706cf42a62729dccfc57230115:

  ARM: at91: add Acme Systems Fox G20 board (2013-04-19 12:38:26 +0200)

----------------------------------------------------------------
RTC modification and USART addition for at91sam9x5 SoC.
RTC addition and UART modifications for Aria G25 board.
Addition of Acme Systems Fox G20 board.

----------------------------------------------------------------
Douglas Gilbert (1):
      ARM: at91: add Acme Systems Fox G20 board

Nicolas Ferre (4):
      ARM: at91: at91sam9x5 RTC is not compatible with at91rm9200 one
      ARM: at91/at91-ariag25.dts: add RTC node
      ARM: at91/at91sam9x5.dtsi: add UART0/1 nodes
      ARM: at91/at91-ariag25.dts: UART0/1 nodes are disabled

 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/at91-ariag25.dts |  21 +++--
 arch/arm/boot/dts/at91-foxg20.dts  | 157 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |  20 ++++-
 4 files changed, 192 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-foxg20.dts

-- 
Nicolas Ferre
