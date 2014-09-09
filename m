From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Sep 2014 17:55:55 +0100
Subject: [PATCH v2] spi: davinci: add support for adding delay between
 word's transmission
In-Reply-To: <1410278851-10783-1-git-send-email-grygorii.strashko@ti.com>
References: <1410278851-10783-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20140909165555.GD2601@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 07:07:31PM +0300, Grygorii Strashko wrote:

> - ti,spi-c2t-delay: Chip-select-active-to-transmit-start delay
> 	(SPIDELAY.C2TDELAY)

> - ti,spi-t2c-delay: Transmit-end-to-chip-select-inactive delay
> 	(SPIDELAY.T2CDELAY)

Now I look at these they look very much like the standard delay feature
that the SPI subsystem has already - are they?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140909/ed08dafc/attachment.sig>
