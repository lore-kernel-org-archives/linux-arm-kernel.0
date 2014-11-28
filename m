From: linux@rempel-privat.de (Oleksij Rempel)
Date: Fri, 28 Nov 2014 17:54:13 +0100
Subject: [PATCH 0/4] suport for Alphascale ASM9260, part 4
In-Reply-To: <201411281509.19170.arnd@arndb.de>
References: <201411281509.19170.arnd@arndb.de>
Message-ID: <1417193657-31602-1-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oleksij Rempel (4):
  ARM: clocksource: add asm9260_timer driver
  ARM: dts: add DT for Alphascale ASM9260 SoC
  ARM: add alphascale,acc.txt bindings documentation
  add Alphascale to vendor-prefixes.txt

 .../devicetree/bindings/clock/alphascale,acc.txt   | 115 +++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/alphascale-asm9260-devkit.dts    |  13 ++
 arch/arm/boot/dts/alphascale-asm9260.dtsi          |  63 ++++++
 drivers/clocksource/Kconfig                        |   9 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/asm9260_timer.c                | 220 +++++++++++++++++++++
 8 files changed, 424 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/alphascale,acc.txt
 create mode 100644 arch/arm/boot/dts/alphascale-asm9260-devkit.dts
 create mode 100644 arch/arm/boot/dts/alphascale-asm9260.dtsi
 create mode 100644 drivers/clocksource/asm9260_timer.c

-- 
1.9.1
