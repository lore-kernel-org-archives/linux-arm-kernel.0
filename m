From: b44548@freescale.com (Chao Fu)
Date: Fri, 16 Aug 2013 11:08:51 +0800
Subject: [PATCH v3 0/4]Add Freescale DSPI driver for Vybrid VF610 platform  
Message-ID: <1376622535-8474-1-git-send-email-b44548@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is the SPI master mode driver and has been tested on Vybrid VF610TWR board.
Changes in v2:
- Add a document for DSPI driver under Documentation/devicetree/bindings/spi/.
- Move spi-num-chipselects info dtsi nodes.
Changes in v3:
- Remove two dts properties(dbr,pbr) from  documentation bindings, they will be calculated in code.
- Update driver code in bitbang framework.
- Brief some functions in driver code.
