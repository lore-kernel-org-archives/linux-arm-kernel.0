From: jiri.pinkava@vscht.cz (jiri.pinkava at vscht.cz)
Date: Wed, 6 Apr 2011 01:06:02 +0200
Subject: [PATCH 0/6] n35: Fixes and clean up for Acer n30/n35
Message-ID: <1302044768-7774-1-git-send-email-jiri.pinkava@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[PATCH 1/6] n35: Fix key code values for some GPIO keys.
[PATCH 2/6] n35: Update GPIO documentation
[PATCH 3/6] n30: Clean up UARTs configuration
[PATCH 4/6] n30: Fix MMC power management
[PATCH 5/6] n30: Add touchscreen support for Acer n30 / n35
[PATCH 6/6] n35: Add support for LCD backlight regulation

 arch/arm/mach-s3c2410/Kconfig                    |    1 +
 arch/arm/mach-s3c2410/mach-n30.c                 |  133 ++++++++++++++++++----
 arch/arm/plat-samsung/include/plat/regs-serial.h |    3 +
 3 files changed, 116 insertions(+), 21 deletions(-)
