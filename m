From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  3 Jun 2013 14:42:24 +0100
Subject: [PATCH 00/21] ARM: ux500: Enable Clock look-up from Device Tree
Message-ID: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nice and simple implementation using standard Clk APIs.

 arch/arm/boot/dts/dbx5x0.dtsi    |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/snowball.dts   |    3 ++-
 arch/arm/mach-ux500/cpu-db8500.c |   36 +--------------------------
 drivers/clk/ux500/u8500_clk.c    |  154 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 249 insertions(+), 38 deletions(-)
