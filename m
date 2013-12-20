From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 20 Dec 2013 12:43:26 +0100
Subject: [PATCH v2 0/2] regulator: tps65910: backup battery regulator
Message-ID: <1387539808-24910-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

backup battery charger regulator for tps65910.

Regards,

Markus


Changes in v2:
 - Seperate ops for vbb to reduce performance impact for other regulators on
   voltage mapping
 - Usage of switch statements

Markus Pargmann (2):
  regulator: tps65910: Add backup battery regulator
  ARM: dts: tps65910 backup battery regulator

 Documentation/devicetree/bindings/mfd/tps65910.txt |  4 +-
 arch/arm/boot/dts/tps65910.dtsi                    |  5 ++
 drivers/regulator/tps65910-regulator.c             | 56 +++++++++++++++++++++-
 include/linux/mfd/tps65910.h                       |  3 +-
 4 files changed, 64 insertions(+), 4 deletions(-)

-- 
1.8.5.1
