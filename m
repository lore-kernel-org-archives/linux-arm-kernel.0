From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  5 Jul 2012 14:06:03 +0100
Subject: [PATCH 0/9] Final batch of clean-ups bound for v3.6
Message-ID: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In this patch-set we provide the last batch of clean-ups related 
to the Device Tree enablement of Snowball and other DB8500 based
chipsets. Most of these clean-ups are nice and  easy 
simplifications of code, or recommendations from particular 
Mainline Maintainers.

 .../devicetree/bindings/gpio/gpio-nmk.txt          |    2 +-
 arch/arm/boot/dts/db8500.dtsi                      |   18 +-
 arch/arm/mach-ux500/board-mop500-regulators.c      |  176 --------------------
 arch/arm/mach-ux500/board-mop500-regulators.h      |    2 -
 arch/arm/mach-ux500/board-mop500.c                 |   20 +--
 arch/arm/mach-ux500/cpu-db8500.c                   |   13 +-
 drivers/input/misc/ab8500-ponkey.c                 |    2 +
 drivers/pinctrl/pinctrl-nomadik.c                  |    4 +-
 include/linux/mfd/abx500/ab8500.h                  |    3 -
 9 files changed, 18 insertions(+), 222 deletions(-)
