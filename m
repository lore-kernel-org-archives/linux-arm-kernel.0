From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Sat, 23 Aug 2014 08:15:32 +0800
Subject: [PATCH 0/2] Rockchip SoC thermal driver
Message-ID: <1408752934-18318-1-git-send-email-caesar.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the thermal Found on Rockhip SoCs.

Caesar Wang (2):
  dt-bindings: document Rockchip thermal
  thermal: rockchip: add driver for Rockchip thermal

Tested on rk3288 Board.
 .../bindings/thermal/rockchip-thermal.txt          |   33 +
 drivers/thermal/Kconfig                            |    9 +
 drivers/thermal/Makefile                           |    1 +
 drivers/thermal/rockchip_thermal.c                 |  659 ++++++++++++++++++++
 4 files changed, 702 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
 create mode 100644 drivers/thermal/rockchip_thermal.c

-- 
1.7.9.5
