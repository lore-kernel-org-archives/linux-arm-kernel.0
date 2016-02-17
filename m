From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Feb 2016 16:05:35 +0000
Subject: [PATCH 01/13] spi: imx: allow only WML aligned transfers to use
 DMA
In-Reply-To: <20160217150146.GC3939@pengutronix.de>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
 <1455715739-25161-2-git-send-email-s.hauer@pengutronix.de>
 <20160217141619.GR7544@sirena.org.uk>
 <20160217150146.GC3939@pengutronix.de>
Message-ID: <20160217160535.GW7544@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 04:01:46PM +0100, Sascha Hauer wrote:

> You seem to have a template for this, I remember having read the same
> text before ;)

I do, but even before I had a template I'd always end up typing the same
thing by hand anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/c79057ee/attachment-0001.sig>
