From: luis@debethencourt.com (Luis de Bethencourt)
Date: Fri, 28 Aug 2015 14:42:22 +0200
Subject: [PATCH 0/5] clk: sunxi: Fix module autoload for OF platform driver
Message-ID: <20150828124222.GA24923@goodgumbo.baconseed.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series add the missing MODULE_DEVICE_TABLE() for OF to eport
that information so modules have the correct aliases built-in
and autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

Luis de Bethencourt (5)
  clk: sunxi: sun9i-mmc: Fix module autoload for OF platform driver
  clk: sunxi: sun8i-apb0: Fix module autoload for OF platform driver
  clk: sunxi: sun6i-ar100: Fix module autoload for OF platform driver
  clk: sunxi: sun6i-apb0-gates: Fix module autoload for OF platform driver
  clk: sunxi: sun6i-apb0: Fix module autoload for OF platform driver
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c | 1 +
 drivers/clk/sunxi/clk-sun6i-apb0.c       | 1 +
 drivers/clk/sunxi/clk-sun6i-ar100.c      | 1 +
 drivers/clk/sunxi/clk-sun8i-apb0.c       | 1 +
 drivers/clk/sunxi/clk-sun9i-mmc.c        | 1 +
 5 files changed, 5 insertions(+)

--
2.4.6
