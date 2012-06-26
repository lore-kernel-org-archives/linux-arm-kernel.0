From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 16:45:05 +0800
Subject: [PATCH 0/3] fec driver updates
Message-ID: <1340700308-8315-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series makes a few updates on fec driver to make it work better
for device tree boot.

Shawn Guo (3):
  net: fec: reset phy after pinctrl setup
  net: fec: enable regulator for fec phy
  net: fec: add phy-reset-interval for device tree probe

 Documentation/devicetree/bindings/net/fsl-fec.txt |    5 ++++-
 drivers/net/ethernet/freescale/fec.c              |   21 ++++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
1.7.5.4
