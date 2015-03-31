From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Mar 2015 17:21:58 +0100
Subject: [PATCH v2] spi: bitbang: only toggle bitchanges
In-Reply-To: <1427812501-7194-1-git-send-email-m.grzeschik@pengutronix.de>
References: <20150331141321.GR2869@sirena.org.uk>
 <1427812501-7194-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20150331162158.GU2869@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 04:35:01PM +0200, Michael Grzeschik wrote:
> The current implementation of bitbang_txrx_be_cpha0 and
> bitbang_txrx_be_cpha1 always call setmosi. That runs into several
> unnecessary calls into the gpiolib when the level of the GPIO actually
> has not to be changed.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150331/4c018f9a/attachment.sig>
