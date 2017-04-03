From: david@lechnology.com (David Lechner)
Date: Mon,  3 Apr 2017 15:23:46 -0500
Subject: [PATCH 0/3] LEGO MINDSTORMS EV3 Battery
Message-ID: <1491251029-23256-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the LEGO MINDSTORMS EV3 battery.

David Lechner (3):
  dt-bindings: power: supply: New bindings for LEGO MINDSTORMS EV3
    battery
  power: supply: New driver for LEGO MINDSTORMS EV3 battery
  ARM: dts: da850: Add node for LEGO MINDSTORMS EV3 Battery

 .../bindings/power/supply/lego_ev3_battery.txt     |  21 ++
 arch/arm/boot/dts/da850-lego-ev3.dts               |  28 +++
 drivers/power/supply/Kconfig                       |   6 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/lego_ev3_battery.c            | 237 +++++++++++++++++++++
 5 files changed, 293 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt
 create mode 100644 drivers/power/supply/lego_ev3_battery.c

-- 
2.7.4
