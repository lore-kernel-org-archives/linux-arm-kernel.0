From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 11:21:39 +0800
Subject: [PATCH v2 0/2] flexcan driver updates
Message-ID: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
* Add phy-standby-gpios support
* Remove enable-active-low and use of_get_named_gpio_flags instead
* Use devm_gpio_request_one instead of gpio_request_one

Shawn Guo (2):
  net: flexcan: clock-frequency is optional for device tree probe
  net: flexcan: add transceiver switch gpios support

 .../devicetree/bindings/net/can/fsl-flexcan.txt    |    5 ++
 drivers/net/can/flexcan.c                          |   62 ++++++++++++++++++++
 2 files changed, 67 insertions(+), 0 deletions(-)

-- 
1.7.5.4
