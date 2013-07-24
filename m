From: b44548@freescale.com (Chao Fu)
Date: Wed, 24 Jul 2013 13:32:19 +0800
Subject: [PATCH v2 0/4]Add Freescale DSPI driver for Vybrid VF610 platform 
Message-ID: <1374643943-3324-1-git-send-email-b44548@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is the SPI master mode driver and has been tested on Vybrid VF610TWR board.
Changes in v2:
- Add a document for DSPI driver under Documentation/devicetree/bindings/spi/.
- Move spi-num-chipselects info dtsi nodes.
