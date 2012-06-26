From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 16:49:21 +0800
Subject: [PATCH 0/2] flexcan driver updates
Message-ID: <1340700563-8386-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are a couple of flexcan driver/bindings updates, which are meant
to get the driver more device tree friendly.

Shawn Guo (2):
  net: flexcan: clock-frequency is optional for device tree probe
  net: flexcan: add transceiver switch gpio support

 .../devicetree/bindings/net/can/fsl-flexcan.txt    |    6 ++++
 drivers/net/can/flexcan.c                          |   30 ++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

-- 
1.7.5.4
