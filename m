From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Wed,  7 Sep 2016 09:41:38 +0200
Subject: [PATCH v3 0/8] dts: sun8i-h3: complete UART I2C definitions for H3
Message-ID: <1473234106-32330-1-git-send-email-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

This is my third attempt to complete the UART/I2C definitions on H3.
Changes since v2:
 * I have moved the pinmux/peripheral associations to the H3 DTSI file,
   including already existing associations for UART0 and UART1.
 * I have left out _a and @0 prefixes where there is only one option
 * I have added i2c2, since it is there (although not exposed on my test
   board)

Best,

Jorik

Jorik Jonker (8):
  dts: sun8i-h3: drop _a and address suffix from uart0 pinmux
  dts: sun8i-h3: clarify uart1 pinmux definition name
  dts: sun8i-h3: move uart0 pinmux/peripheral assocation to DSTI
  dts: sun8i-h3: move uart1 pinmux/peripheral assocation to DSTI
  dts: sun8i-h3: add pinmux definitions for UART2-3
  dts: sun8i-h3: associate pinmux/peripherals for UART2-3
  dts: sun8i-h3: add pinmux definitions for I2C0-2
  dts: sun8i-h3: add I2C0-2 peripherals to H3 SOC

 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts |  4 --
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts       |  2 -
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts     |  2 -
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts      |  2 -
 arch/arm/boot/dts/sun8i-h3.dtsi                 | 86 ++++++++++++++++++++++++-
 5 files changed, 84 insertions(+), 12 deletions(-)

-- 
2.7.4
