From: b44548@freescale.com (Chao Fu)
Date: Fri, 30 Aug 2013 11:19:47 +0800
Subject: [PATCH v4 0/2]Add Freescale DSPI driver for Vybrid VF610 platform 
Message-ID: <1377832789-5238-1-git-send-email-b44548@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is the SPI master mode driver and has been tested on Vybrid 
VF610TWR board.
Changes in v2:
- Add a document for DSPI driver under Documentation/devicetree/bindings/spi/.
- Move spi-num-chipselects info dtsi nodes.
Changes in v3:
- Remove two dts properties(dbr,pbr) from  documentation bindings, they will be 
calculated in code.
- Update driver code in bitbang framework.
- Brief some functions in driver code.
Changes in v4:
- Correct new dtsi node (DSPI0) in order.
- Remove two unnecessary dts properties. 
