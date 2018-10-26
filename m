From: Claudiu.Beznea@microchip.com (Claudiu.Beznea at microchip.com)
Date: Fri, 26 Oct 2018 16:19:45 +0000
Subject: [PATCH 0/2] add PM functionality for act8945
Message-ID: <1540570753-16370-1-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements PM functionality for act8945 and use that support
on sama5d2_xplained board.

Boris Brezillon (2):
  regulator: act8945: Implement PM functionalities
  ARM: dts: at91: sama5d2_xplained: Add proper regulator states for
    suspend-to-mem

 arch/arm/boot/dts/at91-sama5d2_xplained.dts |  33 +++++
 drivers/regulator/act8945a-regulator.c      | 195 +++++++++++++++++++++++++++-
 2 files changed, 226 insertions(+), 2 deletions(-)

-- 
2.7.4
