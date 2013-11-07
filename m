From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu,  7 Nov 2013 10:00:42 -0800
Subject: [PATCH v3 0/2] clk/zynq: fclk-enable feature
Message-ID: <1383847244-2079-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is v3. The only change is a doc fix. Regarding the vendor prefix for
properties, I counted one vote for it and one against + the already existing
bindings that don't have a vendor prefix and my personal preference; and nobody
else seems to have a strong opinion on this. Therefore I left it out.

	Thanks,
	S?ren

Soren Brinkmann (2):
  clk/zynq/clkc: Add 'fclk-enable' feature
  arm: dt: zynq: Add fclk-enable property to clkc node

 Documentation/devicetree/bindings/clock/zynq-7000.txt |  4 ++++
 arch/arm/boot/dts/zynq-7000.dtsi                      |  1 +
 drivers/clk/zynq/clkc.c                               | 18 +++++++++++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

-- 
1.8.4.2
