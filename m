From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 29 Jul 2014 09:24:42 +0200
Subject: [PATCH 0/4] gpio: pca953x updates for DT
Message-ID: <1406618686-22385-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

here are some updates for the pca953x driver for handling DT. The series
includes some cleanup of deprecated DT properties, adds documentation and
handling of reset gpio for the chip.

Best regards,

Markus


Markus Pargmann (4):
  gpio: pca953x: Drop deprecated DT bindings
  gpio: pca953x: Add DT binding documentation
  gpio: pca953x: Add pca9506 as DT compatible
  gpio: pca953x: Add DT binding for reset gpio

 .../devicetree/bindings/gpio/gpio-pca953x.txt      | 45 +++++++++++++
 drivers/gpio/gpio-pca953x.c                        | 73 +++++++---------------
 2 files changed, 67 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-pca953x.txt

-- 
2.0.1
