From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 10 Mar 2014 13:34:15 +0100
Subject: [PATCH 0/3] clk: s2mps11: Add support for S2MPS14 clocks
Message-ID: <1394454858-3139-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds support for the S2MPS14 device to the s2mps11 clock
driver.

The patchset *depends on*:
1. Work done by Tushar Behera:
   [PATCH V2 0/2] Add support for clocks in S5M8767
   http://thread.gmane.org/gmane.linux.kernel.samsung-soc/27264
2. Support for S2MPS14 in main sec-core MFD driver (already in linux-next
   and Lee's tree).

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  clk: s2mps11: Add support for S2MPS14 clocks
  mfd: sec-core: Add of_compatible strings for MFD cells
  Documentation: mfd: s2mps11: Describe S5M8767 and S2MPS14 clocks

 Documentation/devicetree/bindings/mfd/s2mps11.txt |   24 +++++---
 drivers/clk/clk-s2mps11.c                         |   61 ++++++++++++++++-----
 drivers/mfd/sec-core.c                            |    3 +
 3 files changed, 64 insertions(+), 24 deletions(-)

-- 
1.7.9.5
