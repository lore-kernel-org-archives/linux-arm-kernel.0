From: anilkumar@ti.com (AnilKumar Ch)
Date: Mon, 5 Nov 2012 16:15:40 +0530
Subject: [PATCH 00/10] ARM: dts: AM33XX: Add device tree data
Message-ID: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree date for GPIO based various drivers matrix keypad,
volume keys, push buttons and use leds accross three AM33XX devices
viz EVM, BeagleBone and Starter Kit.

To make it functional this series also adds pinctrl data for all
the GPIOs used by various drivers. In this series only default state
pinmux/conf settings are added because of sleep/idle state pinctrl
values are not available.

These patches are based on linux-omap-dt:for_3.8/dts tree and these
were tested on am33xx devices according to added functionality.

AnilKumar Ch (10):
  ARM: dts: AM33XX: Add pinmux configuration for matrix keypad to EVM
  ARM: dts: AM33XX: Add matrix keypad device tree data to am335x-evm
  ARM: dts: AM33XX: Add pinmux configuration for volume-keys to EVM
  ARM: dts: AM33XX: Add volume-keys device tree data to am335x-evm
  ARM: dts: AM33XX: Add pinmux configuration for user-leds to BONE
  ARM: dts: AM33XX: Add user-leds device tree data to am335x-bone
  ARM: dts: AM33XX: Add pinmux configuration for gpio-leds to EVMSK
  ARM: dts: AM33XX: Add user-leds device tree data to am335x-evmsk
  ARM: dts: AM33XX: Add pinmux configuration for gpio-keys to EVMSK
  ARM: dts: AM33XX: Add push-buttons device tree data to am335x-evmsk

 arch/arm/boot/dts/am335x-bone.dts  |   44 +++++++++++++++++++
 arch/arm/boot/dts/am335x-evm.dts   |   63 +++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-evmsk.dts |   84 ++++++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+)

-- 
1.7.9.5
