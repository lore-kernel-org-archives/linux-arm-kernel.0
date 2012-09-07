From: jm@lentin.co.uk (Jamie Lentin)
Date: Fri,  7 Sep 2012 17:34:33 +0100
Subject: [PATCH 0/2] hwmon: kirkwood: Add DT bindings to gpio-fan for
 DNS-32[05]
Message-ID: <1347035675-23907-1-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an attempt at getting DT support into gpio-fan, in a similar
fashion to gpio-leds and gpio-keys. I guess the most contentious bit is
going to be the bindings.

Tested on a D-Link DNS-320.

Feedback appreciated!

Jamie Lentin (2):
  hwmon: Add devicetree bindings to gpio-fan
  ARM: kirkwood: Use devicetree to define DNS-32[05] fan

 .../devicetree/bindings/gpio/gpio-fan.txt          |   25 +++++
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   10 ++
 arch/arm/mach-kirkwood/board-dnskw.c               |   25 -----
 drivers/hwmon/gpio-fan.c                           |  111 ++++++++++++++++++++
 4 files changed, 146 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-fan.txt

-- 
1.7.10.4
