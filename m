From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 19 Aug 2010 17:50:15 +0900
Subject: [PATCH 0/4] Updata S5PC110 GONI board
Message-ID: <4C6CF047.7080507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset is to update GONi board.
Kyungmin sent partial one of this patchset but this is more updated
version.

Thanks.


Joonyoung Shim (2):
       ARM: S5PC110: Add keypad device to the GONI board
       ARM: S5PC110: Add si470x radio device to the GONI board

Kyungmin Park (2):
       ARM: S5PC110: GONI: Add TSP driver
       ARM: S5PC110: GONI: Fixed voltage support for eMMC

  arch/arm/mach-s5pv210/Kconfig     |    6 ++
  arch/arm/mach-s5pv210/mach-goni.c |  156 
+++++++++++++++++++++++++++++++++++++
  2 files changed, 162 insertions(+), 0 deletions(-)
