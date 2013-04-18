From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Apr 2013 15:01:08 +0200
Subject: [PATCH 0/5] ARM: at91: some more DT enhancements
Message-ID: <cover.1366289869.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addition of the Acme systems Fox G20 board and some additions to the
at91sam9x5 DT and Aria board.

Douglas Gilbert (1):
  ARM: at91: add Acme Systems Fox G20 board

Nicolas Ferre (4):
  ARM: at91: at91sam9x5 RTC is not compatible with at91rm9200 one
  ARM: at91/at91-ariag25.dts: add RTC node
  ARM: at91/at91sam9x5.dtsi: add UART0/1 nodes
  ARM: at91/at91-ariag25.dts: UART0/1 nodes are disabled

 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/at91-ariag25.dts |  21 +++--
 arch/arm/boot/dts/at91-foxg20.dts  | 166 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9x5.dtsi  |  20 ++++-
 4 files changed, 201 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-foxg20.dts

-- 
1.8.0
