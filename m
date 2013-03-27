From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Wed, 27 Mar 2013 18:29:11 +0530
Subject: [PATCH 0/5] ARM: dts: AM33XX: Cleanup and pinctrl binding support
Message-ID: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes the numbering schema for I2C and GPIO
module and adds the pin-control binding for I2C, UART, GPIO-LED across
supported platforms (EVM, EVM-SK and Bone).

I have divided patches based on functionality and _not_
into EVM/Board perspective.

Vaibhav Hiremath (5):
  ARM: dts: AM33XX: Fix the i2c numbering to match hardware/TRM
  ARM: dts: AM33XX: Add default pinctrl binding for I2C device
  ARM: dts: AM33XX: Fix gpio numbering to match hardware/TRM
  ARM: dts: AM33XX: Add pinctrl binding to gpio-leds node
  ARM: dts: AM33XX: Add default pinctrl binding for UART0 device

 arch/arm/boot/dts/am335x-bone.dts  |   35 +++++++++++++++++++++----
 arch/arm/boot/dts/am335x-evm.dts   |   48 +++++++++++++++++++++++++++++------
 arch/arm/boot/dts/am335x-evmsk.dts |   43 ++++++++++++++++++++++++-------
 arch/arm/boot/dts/am33xx.dtsi      |   14 +++++-----
 4 files changed, 108 insertions(+), 32 deletions(-)
