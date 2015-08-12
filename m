From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 11:37:36 +0100
Subject: [PATCH 00/20] Regmap max_raw_io and bmc150 SPI support
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20150812103736.GR10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:12:25PM +0200, Markus Pargmann wrote:
> Hi,
> 
> this series was created to add SPI support to the bmc150 accelerometer driver.
> To not add any regressions, I had to add some infrastructure that allows to use
> regmap with busses that do limit the size of transfers (block smbus). I hope
> this is sufficient to not break anything.

This is a really big series but looking at at least the initial patches
there's a lot of unrelated cleanups mixed in with it.  Please don't do
this, send things like cleanups separately so that your series is
focused on the relevant topic.  This makes things much easier to work
with.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/8f2eb69e/attachment.sig>
