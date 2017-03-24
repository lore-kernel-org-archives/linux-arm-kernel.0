From: broonie@kernel.org (Mark Brown)
Date: Fri, 24 Mar 2017 19:09:55 +0000
Subject: [alsa-devel] [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
In-Reply-To: <64802e9b-ffe9-65e3-502a-4253674fb4c7@flatmax.org>
References: <20170228095929.GH2742@localhost.localdomain>
 <20170315190108.y6ybxm3nfgnutajv@sirena.org.uk>
 <7d8d38f7-53aa-cc3d-4bbd-141649528a8a@flatmax.org>
 <8c62f014-d246-e0c1-2b02-a28a2c2786b7@metafoo.de>
 <000fbaa4-4c7c-5b13-0806-7e42672a4a55@flatmax.org>
 <e0adcc6c-8bf4-adae-874b-c291e71e5712@laposte.net>
 <20170321221145.GA7258@camel2.lan>
 <579f0763-a5bd-f820-b36f-b6437e331b4b@flatmax.org>
 <20170322094301.GE6986@localhost.localdomain>
 <64802e9b-ffe9-65e3-502a-4253674fb4c7@flatmax.org>
Message-ID: <20170324190955.nxw5az4mza2ia6wl@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 11:04:34PM +1100, Matt Flax wrote:
> On 22/03/17 20:43, Charles Keepax wrote:

> > Are we saying that what gets transmitted on the bus is neither valid
> > I2S or DSP mode data? But as you have your custom hardware block in
> > the middle it interprets this data correctly and converts it to a
> > regular bus format on the other side that goes to the CODEC?

> Yes, essentially there is translation between the two data word edge
> triggered ABP (the bcm2835's PCM block) and a Cirrus Logic TDM codec.

Could you please be concrete about what the two formats you're talking
about here are and how these differences are observable on the wire?  I
don't know what "two data word edge triggered ABP" means.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170324/e11e4711/attachment.sig>
