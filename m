From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Sep 2013 08:31:36 +0800
Subject: [PATCH v4 0/2]Add Freescale DSPI driver for Vybrid VF610 platform
In-Reply-To: <1377832789-5238-1-git-send-email-b44548@freescale.com>
References: <1377832789-5238-1-git-send-email-b44548@freescale.com>
Message-ID: <20130903003133.GD17900@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 11:19:47AM +0800, Chao Fu wrote:
> This driver is the SPI master mode driver and has been tested on Vybrid 
> VF610TWR board.

Applied both, thanks.

Shawn

> Changes in v2:
> - Add a document for DSPI driver under Documentation/devicetree/bindings/spi/.
> - Move spi-num-chipselects info dtsi nodes.
> Changes in v3:
> - Remove two dts properties(dbr,pbr) from  documentation bindings, they will be 
> calculated in code.
> - Update driver code in bitbang framework.
> - Brief some functions in driver code.
> Changes in v4:
> - Correct new dtsi node (DSPI0) in order.
> - Remove two unnecessary dts properties. 
> 
> 
