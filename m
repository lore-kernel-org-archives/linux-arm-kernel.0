From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 6 Aug 2015 14:08:22 +0300
Subject: [GIT PULL] omap clock dts changes for v4.3 merge window
Message-ID: <55C34026.20101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

   Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

   https://github.com/t-kristo/linux-pm.git for-4.3/ti-clk-dt

for you to fetch changes up to dff8a207815a605872dfc5bffc1bae1cad29d87c:

   ARM: dts: am4372: Set the default clock rate for dpll_clksel_mac_clk 
clock (2015-07-31 12:13:18 +0300)

----------------------------------------------------------------
Keerthy (2):
       ARM: dts: AM437X: add dpll_clksel_mac_clk node
       ARM: dts: am4372: Set the default clock rate for 
dpll_clksel_mac_clk clock

  arch/arm/boot/dts/am4372.dtsi        |    7 +++++--
  arch/arm/boot/dts/am43xx-clocks.dtsi |    9 +++++++++
  drivers/clk/ti/clk-43xx.c            |    1 +
  3 files changed, 15 insertions(+), 2 deletions(-)
