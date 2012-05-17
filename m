From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 May 2012 14:45:05 +0100
Subject: [PATCH 00/18] DT enablement for Snowball
Message-ID: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hopefully the penultimate large patch-stack for Snowball
enablement. After that only bits and bobs will remain.

 arch/arm/boot/dts/db8500.dtsi      |   92 +++++++++++++++-
 arch/arm/boot/dts/snowball.dts     |    3 +
 arch/arm/configs/u8500_defconfig   |    3 +
 arch/arm/mach-ux500/Kconfig        |    1 +
 arch/arm/mach-ux500/board-mop500.c |   55 +++-------
 drivers/i2c/busses/i2c-nomadik.c   |   43 +++++++-
 drivers/mfd/Makefile               |    5 +-
 drivers/mfd/ab8500-core.c          |  176 ++++++++++++++++++++++++++-----
 drivers/mfd/ab8500-debugfs.c       |    6 ++
 drivers/mfd/ab8500-gpadc.c         |    8 +-
 drivers/mfd/ab8500-i2c.c           |  160 ----------------------------
 drivers/regulator/ab8500.c         |  204 +++++++++++++++++++++++++-----------
 12 files changed, 457 insertions(+), 299 deletions(-)
