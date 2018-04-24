From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 24 Apr 2018 20:05:02 +0530
Subject: [PATCH 0/4] ARM: davinci: GPIO look-up fixes for legacy boot
Message-ID: <20180424143506.25793-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I noticed that several GPIO lookup issues creeped up due
to changes done in recent past. Here are fixes for these
issues.

Tested on DM644x, DM355, DA830 and DA850 EVMs.

Sekhar Nori (4):
  ARM: davinci: board-da830-evm: fix GPIO lookup for MMC/SD
  ARM: davinci: board-da850-evm: fix GPIO lookup for MMC/SD
  ARM: davinci: fix GPIO lookup for I2C
  ARM: davinci: board-omapl138-hawk: fix GPIO numbers for MMC/SD lookup

 arch/arm/mach-davinci/board-da830-evm.c     |  9 +++++++--
 arch/arm/mach-davinci/board-da850-evm.c     |  9 +++++++--
 arch/arm/mach-davinci/board-dm355-evm.c     |  6 +++---
 arch/arm/mach-davinci/board-dm644x-evm.c    |  6 +++---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 10 +++++++---
 5 files changed, 27 insertions(+), 13 deletions(-)

-- 
2.16.2
