From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 May 2011 17:57:23 +0800
Subject: [PATCH 0/3] remove mach-mxs gpio driver
Message-ID: <1305885446-27404-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is to remove mach-mxs gpio driver and use gpio-mxs
driver under drivers/gpio.

Shawn Guo (3):
      ARM: mxs: remove gpio driver from mach-mxs
      ARM: mxs: add gpio-mxs platform devices
      ARM: mxs: select GPIO_MXS for i.MX23 and i.MX28

 arch/arm/mach-mxs/Kconfig                     |    2 +
 arch/arm/mach-mxs/Makefile                    |    2 +-
 arch/arm/mach-mxs/devices/Makefile            |    1 +
 arch/arm/mach-mxs/devices/platform-gpio-mxs.c |   92 +++++++
 arch/arm/mach-mxs/gpio.c                      |  331 -------------------------
 arch/arm/mach-mxs/gpio.h                      |   34 ---
 arch/arm/mach-mxs/mach-mx28evk.c              |    1 -
 arch/arm/mach-mxs/mm-mx23.c                   |    1 -
 arch/arm/mach-mxs/mm-mx28.c                   |    1 -
 9 files changed, 96 insertions(+), 369 deletions(-)

Regards,
Shawn
