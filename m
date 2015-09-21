From: B48286@freescale.com (Zhiqiang Hou)
Date: Mon, 21 Sep 2015 20:22:32 +0800
Subject: [PATCH 0/6] Add LS1043A SoC support
Message-ID: <1442838158-2964-1-git-send-email-B48286@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchest adds support for Freescale's LS1043A SoC which is
based on ARMv8 architecture.

Some pending patches are depended on:
1. The LS1043A is belong to Freescale's ARMv8 Layerscape SoC family,
so depends on the updating ARCH kconfig patch.
https://patchwork.kernel.org/patch/7120101/

2. The LS1043A use the new clockgen binding updated by Scott Wood,
depends on the patchset:
https://patchwork.kernel.org/patch/7225421/
https://patchwork.kernel.org/patch/7225461/
https://patchwork.kernel.org/patch/7225431/
https://patchwork.kernel.org/patch/7225441/
https://patchwork.kernel.org/patch/7225451/

[PATCH 1/6] i2c: Add i2c support to Freescale Layerscape platforms
[PATCH 2/6] watchdog: Add support for Freescale Layerscape platforms
[PATCH 3/6] Documentation: DT: Add entry for FSL LS1043ARDB board
[PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
[PATCH 5/6] clk: qoriq: Add ls1043a support.
[PATCH 6/6] dts/ls1043a: add LS1043ARDB board support
