From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 29 Jun 2018 17:11:29 +0900
Subject: [PATCH 0/2] reset: uniphier: add USB3 controller reset support
Message-ID: <1530259891-18822-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add new USB3 reset control support for UniPhier SoCs.
This reset lines is included in USB3 glue layer.

Kunihiko Hayashi (2):
  dt-bindings: reset: uniphier: add USB3 controller reset support
  reset: uniphier: add USB3 controller reset control

 .../devicetree/bindings/reset/uniphier-reset.txt   |  45 +++++
 drivers/reset/Kconfig                              |  10 ++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-uniphier-usb3.c                | 183 +++++++++++++++++++++
 4 files changed, 239 insertions(+)
 create mode 100644 drivers/reset/reset-uniphier-usb3.c

-- 
2.7.4
