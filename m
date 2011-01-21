From: sundar.iyer@stericsson.com (Sundar Iyer)
Date: Fri, 21 Jan 2011 10:56:14 +0530
Subject: [PATCH 0/4] mach-ux500: add input devices
Message-ID: <1295587578-14461-1-git-send-email-sundar.iyer@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce dynamic User Interface Board (UIB) detection for the
U8500 platform. Add platform data for the different UIBs supported.

Also fix a ux500 build issue.

Rabin Vincent (1):
  mach-ux500: dynamic UIB (user interface boards) detection

Sundar Iyer (3):
  mach-ux500: fix ux500 build error
  mach-ux500: add ST-UIB platform data
  mach-ux500: add U8500 UIB platform data

 arch/arm/mach-ux500/Makefile                |    7 +-
 arch/arm/mach-ux500/board-mop500-stuib.c    |  196 +++++++++++++++++++++++++++
 arch/arm/mach-ux500/board-mop500-u8500uib.c |  112 +++++++++++++++
 arch/arm/mach-ux500/board-mop500-uib.c      |  136 +++++++++++++++++++
 arch/arm/mach-ux500/board-mop500.c          |    5 +-
 arch/arm/mach-ux500/board-mop500.h          |    9 +-
 arch/arm/mach-ux500/include/mach/gpio.h     |   29 ++++
 7 files changed, 488 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-stuib.c
 create mode 100644 arch/arm/mach-ux500/board-mop500-u8500uib.c
 create mode 100644 arch/arm/mach-ux500/board-mop500-uib.c

-- 
1.7.2.dirty
