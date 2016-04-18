From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Apr 2016 12:04:15 +0100
Subject: [PATCH v5] spi: orion.c: Add direct access mode
In-Reply-To: <4437692.8jaX7AeWuo@wuerfel>
References: <1460974417-32375-1-git-send-email-sr@denx.de>
 <4437692.8jaX7AeWuo@wuerfel>
Message-ID: <20160418110415.GT3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 12:51:55PM +0200, Arnd Bergmann wrote:

> This would be easier if have a conclusive proof that 1MB per CS always enough.
> Is this something that is guaranteed in the SPI spec or the documentation for
> this controller?

There's no spec for SPI but if there were it'd be hard to see it
imposing a limit, one can transfer data as long as the bus is clocked
(which some things like ADCs and DACs make use of).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160418/d05f292c/attachment.sig>
