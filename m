From: sourav.poddar@ti.com (Sourav Poddar)
Date: Wed, 4 Apr 2012 19:00:19 +0530
Subject: [PATCH 0/2] Add device tree support for omap4 keypad
Message-ID: <1333546221-19700-1-git-send-email-sourav.poddar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds device tree support for omap4
onchip keypad.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Felipe Balbi <balbi@ti.com>

Sourav Poddar (2):
  arm/dts: omap4-sdp: Add keypad data
  drivers: input: keypad: Add device tree support

Test Info:
-Tested on Omap4430 sdp with 3.4-rc1

 .../devicetree/bindings/input/omap-keypad.txt      |   52 ++++
 arch/arm/boot/dts/omap4-sdp.dts                    |  291 ++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |    5 +
 drivers/input/keyboard/omap4-keypad.c              |  114 ++++++--
 4 files changed, 439 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/omap-keypad.txt
