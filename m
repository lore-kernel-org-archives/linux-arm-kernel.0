From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Dec 2014 18:12:44 +0000
Subject: [PATCH v2 2/6] ASoC: dwc: Ensure FIFOs are flushed to prevent
 channel swap
In-Reply-To: <548AB75E.9030302@metafoo.de>
References: <cover.1418372910.git.Andrew.Jackson@arm.com>
 <a3b4a11dfe1688eea07471c6cfa27676cc9a58a8.1418372910.git.Andrew.Jackson@arm.com>
 <548AB75E.9030302@metafoo.de>
Message-ID: <20141212181244.GQ11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 12, 2014 at 10:37:34AM +0100, Lars-Peter Clausen wrote:

> This should probably go into the prepare callback. prepare is for example
> also called when recovering from a underrun/overrun. Whereas hwparams is
> only called during initial setup of the stream.

Indeed, that's a better place.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141212/11f10dcc/attachment-0001.sig>
