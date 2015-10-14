From: B48286@freescale.com (Zhiqiang Hou)
Date: Wed, 14 Oct 2015 19:34:52 +0800
Subject: [PATCH V3 0/6] Add LS1043A SoC support 
Message-ID: <1444822498-16477-1-git-send-email-B48286@freescale.com>
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

[PATCH V3 1/6] i2c: Add i2c support to Freescale Layerscape platforms
[PATCH V3 2/6] watchdog: Add support for Freescale Layerscape
[PATCH V3 3/6] Documentation: DT: Add entry for FSL LS1043ARDB board
[PATCH V3 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
[PATCH V3 5/6] clk: qoriq: Add ls1043a support.
[PATCH V3 6/6] dts/ls1043a: add LS1043ARDB board support
