From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Sep 2013 16:51:20 +0100
Subject: [PATCH v2 8/9] spi: prepare runtime PM support for SPI devices
In-Reply-To: <1378913560-2752-9-git-send-email-mika.westerberg@linux.intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-9-git-send-email-mika.westerberg@linux.intel.com>
Message-ID: <20130911155120.GW29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 06:32:39PM +0300, Mika Westerberg wrote:
> This patch adds runtime PM support for the SPI bus analogous to what has
> been done for the I2C bus. This means that the SPI core prepares runtime PM
> for a client device just before a driver is about to be bound to it.
> Devices that are not bound to any driver are not prepared for runtime PM.

Acked-by: Mark Brown <broonie@linaro.org>

I would be able to have this and the other patch in the SPI tree in case
it overlaps with other work - I'm not sure what the plan will be for
merging this stuff but if there were a branch which I could merge into
the SPI tree that'd be good.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/ff0be4e6/attachment.sig>
