From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 09:38:59 +0100
Subject: [PATCH 00/16] The last large installment of DT for Snowball
Message-ID: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Everything to follow will be small, mostly unrelated changes and
enablement of the odd left-over driver.

 arch/arm/boot/dts/db8500.dtsi          |  143 +++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/snowball.dts         |   14 ++++
 arch/arm/configs/u8500_defconfig       |    1 +
 arch/arm/mach-ux500/board-mop500-uib.c |    4 +-
 arch/arm/mach-ux500/board-mop500.c     |   12 ++-
 arch/arm/mach-ux500/board-mop500.h     |    1 +
 drivers/input/misc/ab8500-ponkey.c     |    6 ++
 drivers/mfd/ab8500-sysctrl.c           |    6 ++
 drivers/mfd/db8500-prcmu.c             |    1 +
 drivers/misc/ab8500-pwm.c              |    6 ++
 drivers/regulator/db8500-prcmu.c       |  137 +++++++++++++++++++++++-------
 11 files changed, 297 insertions(+), 34 deletions(-)
