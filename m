From: andreas.westin@stericsson.com (Andreas Westin)
Date: Mon, 26 Mar 2012 15:12:43 +0200
Subject: [PATCH] mach-ux500: Crypto: core support for CRYP/HASH module
Message-ID: <1332767564-23577-1-git-send-email-andreas.westin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the core code required for supporting the UX500 CRYP and HASH
hardware crypto and hash module in the ST-Ericsson UX500 platform.

/Andreas

Andreas Westin (1):
  mach-ux500: Crypto: core support for CRYP/HASH module.

 arch/arm/mach-ux500/board-mop500.c         |   48 ++++++++++++++++++++++++++++
 arch/arm/mach-ux500/board-u5500.c          |   48 ++++++++++++++++++++++++++++
 arch/arm/mach-ux500/clock.c                |   18 ++++++-----
 arch/arm/mach-ux500/devices-common.c       |   16 ++++++++++
 arch/arm/mach-ux500/devices-common.h       |   23 +++++++++++++
 arch/arm/mach-ux500/devices-db5500.h       |    4 +++
 arch/arm/mach-ux500/devices-db8500.h       |    4 +++
 arch/arm/mach-ux500/include/mach/devices.h |    3 ++
 arch/arm/mach-ux500/ste-dma40-db5500.h     |    9 ++++--
 9 files changed, 162 insertions(+), 11 deletions(-)

-- 
1.7.9.4
