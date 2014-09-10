From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 10 Sep 2014 11:16:01 +0800
Subject: [PATCH 0/4] ARM: dts: several updates for the imx28-tx28.dts file
In-Reply-To: <1410261963-27956-1-git-send-email-LW@KARO-electronics.de>
References: <1410261963-27956-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140910031559.GB18566@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 01:25:59PM +0200, Lothar Wa?mann wrote:
> - remove unused labels on spidev nodes
> - add third spidev node to utilize all available CS
> - use GPIO polarity flags
> - add configuration for spi-gpio driver as alternative to spi-mxs
> - add an alias for the can transceiver regulator which is used by U-Boot

Applied all 4, thanks.
