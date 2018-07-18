From: manish.narani@xilinx.com (Manish Narani)
Date: Wed, 18 Jul 2018 16:42:07 +0530
Subject: [PATCH 0/4] iio: adc: xilinx: XADC driver enhancements and bug fixes
Message-ID: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series resolves code style problems as reported by code analysis
tools.

Manish Narani (4):
  iio: adc: xilinx: Rename 'channels' variable name to
    'iio_xadc_channels'
  iio: adc: xilinx: Remove dead code from xadc_zynq_setup
  iio: adc: xilinx: Check for return values in clk related functions
  iio: adc: xilinx: Use devm_ functions while requesting irq

 drivers/iio/adc/xilinx-xadc-core.c | 60 ++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 22 deletions(-)

-- 
2.1.1
