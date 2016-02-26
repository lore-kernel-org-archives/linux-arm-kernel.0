From: broonie@kernel.org (Mark Brown)
Date: Fri, 26 Feb 2016 21:15:42 +0900
Subject: [PATCH RESEND 0/2] spi: sun4i: add DMA support
In-Reply-To: <1456466217-6793-1-git-send-email-plaes@plaes.org>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
Message-ID: <20160226121542.GP18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 07:56:55AM +0200, Priit Laes wrote:
> While trying to get SPI TFT screen working with Cubietruck, I noticed that
> at current state driver didn't actually support SPI data bursts bigger than
> n bytes (n is probably ~64 bytes).

If you're going to add noise like "RESEND" to your subject lines (which
makes the visible space for the actual subject smaller so makes handling
incoming mail harder) please at least make sure it's true, you've not
sent these before.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160226/681c8e01/attachment.sig>
