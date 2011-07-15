From: marvin24@gmx.de (Marc Dietrich)
Date: Fri, 15 Jul 2011 12:24:20 +0200
Subject: [PATCH 0/3] ARM: tegra: paz00: Add Wifi and second serial port support
Message-ID: <1310725464-2524-1-git-send-email-marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin,

the following three patches add the second serial port (some solder points
on the mainboard) and Wifi support (rfkill and LED) to PAZ00.
The second serial port is useful to be able to communicate with the booloader
and also to see early kernel messages.

They were intended for 3.1 but if it's too late, 3.2 is also ok.

Thanks

Marc

Marc Dietrich (3):
  ARM: tegra: paz00: add support serial port on JP1
  ARM: tegra: paz00: export the WIFI rfkill gpio
  ARM: tegra: paz00: enable wifi led

 arch/arm/mach-tegra/board-paz00-pinmux.c |    2 +
 arch/arm/mach-tegra/board-paz00.c        |   50 ++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-paz00.h        |    7 ++++
 3 files changed, 59 insertions(+), 0 deletions(-)

-- 
1.7.4.1
