From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Sat,  3 Oct 2015 21:35:16 +0100
Subject: [PATCH 0/3] hwrng: stm32 - add support for STM32 HW RNG
Message-ID: <1443904519-24012-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces a driver for the STM32 hardware random number
generator.

Daniel Thompson (3):
  dt-bindings: Document the STM32 HW RNG bindings
  hwrng: stm32 - add support for STM32 HW RNG
  ARM: dts: stm32f429: Adopt STM32 RNG driver

 .../devicetree/bindings/hwrng/stm32-rng.txt        |  21 +++
 arch/arm/boot/dts/stm32f429.dtsi                   |   7 +
 drivers/char/hw_random/Kconfig                     |  12 ++
 drivers/char/hw_random/Makefile                    |   1 +
 drivers/char/hw_random/stm32-rng.c                 | 192 +++++++++++++++++++++
 5 files changed, 233 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwrng/stm32-rng.txt
 create mode 100644 drivers/char/hw_random/stm32-rng.c

--
2.4.3
