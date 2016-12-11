From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 11 Dec 2016 14:17:48 -0800
Subject: [PATCH 0/2] FPGA: TS-7300 FPGA manager
Message-ID: <20161211221750.27743-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series adds support for loading bitstreams into the Altera Cyclone II
connected to an EP9302 on a TS-7300 board.

Florian Fainelli (1):
  ARM: ep93xx: Register ts73xx-fpga manager driver for TS-7300
  FPGA: Add TS-7300 FPGA manager

 drivers/fpga/Kconfig       |   7 ++
 drivers/fpga/Makefile      |   1 +
 drivers/fpga/ts73xx-fpga.c | 165 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig        |   7 ++
 4 files changed, 180 insertions(+)
 create mode 100644 drivers/fpga/ts73xx-fpga.c

-- 
2.9.3
