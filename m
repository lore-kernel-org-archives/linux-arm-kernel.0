From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 14 Mar 2012 13:04:56 +0000
Subject: [PATCH 0/10] ARM: ux500: Enable Snowball for Device Tree
Message-ID: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hopefully the first of many, this patch-set starts the process
of enabling Device Tree for ST-Ericsson's low-cost development
platform, Snowball.

 arch/arm/boot/dts/db8500.dtsi      |  275 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/snowball.dts     |  139 ++++++++++++++++++
 arch/arm/configs/u8500_defconfig   |    1 +
 arch/arm/mach-ux500/Kconfig        |    6 +
 arch/arm/mach-ux500/Makefile.boot  |    1 +
 arch/arm/mach-ux500/board-mop500.c |   99 +++++++++++++-
 arch/arm/mach-ux500/cache-l2x0.c   |    7 +-
 arch/arm/mach-ux500/cpu.c          |   12 ++-
 arch/arm/mach-ux500/localtimer.c   |   18 +++-
 9 files changed, 553 insertions(+), 5 deletions(-)
