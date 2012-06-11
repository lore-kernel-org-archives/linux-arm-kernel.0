From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Jun 2012 16:24:53 +0100
Subject: [PATCH 00/14] Final (large) batch of Snowball Device Tree Enablement
Message-ID: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hopefully, this will be the last lot of enablement patches for Snowball.
The only thing to follow this patch-set is clean-ups and enablement of
drivers/power.

Some of these patches have been on the MLs before, but are yet
to be reviewed/SOB the correct people.

In-Reply-To: 
 arch/arm/boot/dts/db8500.dtsi      |   33 +++++++----
 arch/arm/mach-ux500/cpu-db8500.c   |    1 -
 drivers/i2c/busses/i2c-nomadik.c   |   40 ++++++++++++-
 drivers/input/misc/ab8500-ponkey.c |    6 ++
 drivers/mfd/Kconfig                |   11 +---
 drivers/mfd/ab8500-core.c          |  114 +++++++++++++++++++++---------------
 drivers/mfd/ab8500-gpadc.c         |    3 +-
 drivers/mfd/db8500-prcmu.c         |    7 ++-
 drivers/rtc/rtc-ab8500.c           |   10 +++-
 drivers/usb/otg/ab8500-usb.c       |    6 ++
 include/linux/mfd/abx500/ab8500.h  |    4 ++
 11 files changed, 159 insertions(+), 76 deletions(-)
