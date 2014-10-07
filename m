From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Oct 2014 17:20:17 +0100
Subject: [PATCH 4/5] regulator: Use gpio_is_valid
In-Reply-To: <20141007130737.GH5042@pengutronix.de>
References: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
 <1412626635-7404-5-git-send-email-mpa@pengutronix.de>
 <20141007120106.GY4609@sirena.org.uk>
 <20141007130737.GH5042@pengutronix.de>
Message-ID: <20141007162017.GI4609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 03:07:37PM +0200, Markus Pargmann wrote:
> On Tue, Oct 07, 2014 at 01:01:06PM +0100, Mark Brown wrote:
> > On Mon, Oct 06, 2014 at 10:17:14PM +0200, Markus Pargmann wrote:
> > > Use gpio_is_valid instead of custom check.

> > Patches per driver please, this isn't just a mechanical transformation.

> Okay, but you mean just patches 4 and 5 and not patch 2 right?

Mostly, that was OK as it was just mechanical.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/7eada80c/attachment.sig>
