From: marvin24@gmx.de (Marc Dietrich)
Date: Sun,  7 Aug 2011 21:00:50 +0200
Subject: [PATCH 0/5] ARM: tegra: paz00: updates for "for-next"
Message-ID: <cover.1312735430.git.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin,

this is an update to the patches I send on July 15th. There are now five patches
which add the second serial port (some solder points on the mainboard) and Wifi
support (rfkill and LED) to PAZ00. Additionally, usb support is improved and
the SDHCI init order is changed.

Please queue them up for "for-next" after positive review of course.

Thanks

Marc

Marc Dietrich (5):
  ARM: tegra: paz00: add support serial port on JP1
  ARM: tegra: paz00: enable rfkill for internal wifi card
  ARM: tegra: paz00: enable wifi led
  ARM: tegra: paz00: add clocks required for usb operation
  ARM: tegra: paz00: reorder the SDHCI channel init

 arch/arm/mach-tegra/board-paz00-pinmux.c |    3 ++
 arch/arm/mach-tegra/board-paz00.c        |   57 +++++++++++++++++++++++++++++-
 arch/arm/mach-tegra/board-paz00.h        |   16 ++++++--
 3 files changed, 71 insertions(+), 5 deletions(-)

-- 
1.7.4.1
