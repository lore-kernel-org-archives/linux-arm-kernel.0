From: ayaka@soulik.info (Randy Li)
Date: Mon, 22 Aug 2016 04:04:51 +0800
Subject: [PATCH 0/2] Add a new board for exynos 4412
Message-ID: <1471809893-31147-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches would add a support for a new exynos 4412 core
board with a base board.

Although the Samsung Exynos 4412 is a old chip but still powerful.
The main reason I keep to use it is the MFC. It is quite easy
to use the multimedia functions in samsung.  I would like to
go into graphics part in the future.

Anyway, the TOPEET iTOP-4412 have many different version,
I only have Elite and Full version(The other one is Super version).
With two different Core board Chip pakcage(SCP or POP). As I
only have the SCP one, I would only offer support to SCP version.

Randy Li (2):
  ARM: dts: Add TOPEET itop core board SCP package version
  ARM: dts: add TOPEET itop elite based board

 .../bindings/arm/samsung/samsung-boards.txt        |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos4412-itop-elite.dts        | 148 +++++++
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    | 434 +++++++++++++++++++++
 4 files changed, 586 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos4412-itop-elite.dts
 create mode 100644 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi

-- 
2.7.4
