From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 12 Sep 2013 17:55:36 -0700
Subject: [PATCH] SI570 clock driver
Message-ID: <1379033737-30015-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is another try to submit a driver for SI570 programmable clock
generators. The heart of the driver is G?nther's code from
https://github.com/groeck/si570, which is wrapped in the common
clock infrastructure.

Due to the lack of platforms with oder devices only the SI570 is
actually tested.

	Thanks,
	S?ren

Soren Brinkmann (1):
  clk: si570: Add a driver for SI570 oscillators

 .../devicetree/bindings/clock/silabs,si570.txt     |  31 ++
 drivers/clk/Kconfig                                |  10 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-si570.c                            | 546 +++++++++++++++++++++
 4 files changed, 588 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/silabs,si570.txt
 create mode 100644 drivers/clk/clk-si570.c

-- 
1.8.4
