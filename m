From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 13 Mar 2014 10:37:01 +0100
Subject: [PATCH v2 0/3] clk: s2mps11: Add support for S2MPS14 clocks
Message-ID: <1394703425-6462-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is second version of patchset adding support for the S2MPS14
device to the s2mps11 clock driver.


The patchset *depends on*:
==========================
1. Work done by Tushar Behera:
   [PATCH V2 0/2] Add support for clocks in S5M8767
   http://thread.gmane.org/gmane.linux.kernel.samsung-soc/27264
2. Support for S2MPS14 in main sec-core MFD driver (already in linux-next
   and Lee's tree).

Changes since v1:
=================
1. Patch 1/3: Update driver description in Kconfig.
2. Patch 2/3: Add of_compatible to all MFD cells.
3. Add Yadwinder's Review-by.


Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  clk: s2mps11: Add support for S2MPS14 clocks
  mfd: sec-core: Add of_compatible strings for MFD cells
  Documentation: mfd: s2mps11: Describe S5M8767 and S2MPS14 clocks

 Documentation/devicetree/bindings/mfd/s2mps11.txt |   24 +++++---
 drivers/clk/Kconfig                               |    8 +--
 drivers/clk/clk-s2mps11.c                         |   61 ++++++++++++++++-----
 drivers/mfd/sec-core.c                            |    8 +++
 4 files changed, 73 insertions(+), 28 deletions(-)

-- 
1.7.9.5
