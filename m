From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Oct 2012 10:57:03 +0100
Subject: [PATCH 1/8] Ux5x0 patches loosely surrounding u9540 enablement
Message-ID: <1351159031-25391-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kept together mostly for tracking convenience, this patch-set is
the result of platform tweaking during u9540 enablement.

 arch/arm/boot/dts/ccu9540.dts     |   72 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dbx5x0.dtsi     |   14 ++++++++
 arch/arm/boot/dts/hrefprev60.dts  |    2 +-
 arch/arm/boot/dts/hrefv60plus.dts |    2 +-
 arch/arm/boot/dts/snowball.dts    |    2 +-
 arch/arm/boot/dts/stuib.dtsi      |    2 +-
 arch/arm/boot/dts/u9540.dts       |   47 ------------------------
 arch/arm/configs/u8500_defconfig  |    1 +
 arch/arm/mach-ux500/cpu-db8500.c  |   27 +++++---------
 9 files changed, 100 insertions(+), 69 deletions(-)
