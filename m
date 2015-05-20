From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 May 2015 11:37:46 +0100
Subject: [RFC PATCH 1/4] spi: spidev: Add Google SPI flash compatible
 string
In-Reply-To: <555C5F65.7010204@collabora.co.uk>
References: <1432042454-19234-1-git-send-email-javier.martinez@collabora.co.uk>
 <1432042454-19234-2-git-send-email-javier.martinez@collabora.co.uk>
 <20150520101318.GB21577@sirena.org.uk>
 <555C5F65.7010204@collabora.co.uk>
Message-ID: <20150520103746.GD21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 12:18:13PM +0200, Javier Martinez Canillas wrote:
> On 05/20/2015 12:13 PM, Mark Brown wrote:

> > This is adding a binding with no documentation, documentation is
> > mandatory for all bindings.

> Yes, I missed... sorry about that. Do you agree with the approach
> though so I can re-spin the patches adding the missing DT binding?

It's probably OK but I didn't really drill through since the binding was
missing.  If these parts are commodity as described it seems surprising
that they aren't compatible with any existing kernel driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150520/22d5a0a5/attachment.sig>
