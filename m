From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 25 Mar 2016 15:36:24 +0000
Subject: [PATCH 0/4] STi DT updates
Message-ID: <1458920188-29612-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This series adds some more alternate pin configurations which were missing
upstream, the DT config for SSC12, and also a DT node for the 24c256 eeprom.

regards,

Peter.

Peter Griffin (4):
  ARM: DT: STiH407: Add UART RTS/CTS pin configuration
  ARM: DT: STiH407: Add i2c12 pin definition
  ARM: DT: STiH407: Add node for i2c12 controller
  ARM: STi: DT: STiH407: Add DT node for eeprom

 arch/arm/boot/dts/stih407-family.dtsi  | 13 ++++++
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 82 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stihxxx-b2120.dtsi   |  9 ++++
 3 files changed, 104 insertions(+)

-- 
1.9.1
