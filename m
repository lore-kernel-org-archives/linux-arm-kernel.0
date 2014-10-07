From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 7 Oct 2014 15:07:37 +0200
Subject: [PATCH 4/5] regulator: Use gpio_is_valid
In-Reply-To: <20141007120106.GY4609@sirena.org.uk>
References: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
 <1412626635-7404-5-git-send-email-mpa@pengutronix.de>
 <20141007120106.GY4609@sirena.org.uk>
Message-ID: <20141007130737.GH5042@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 01:01:06PM +0100, Mark Brown wrote:
> On Mon, Oct 06, 2014 at 10:17:14PM +0200, Markus Pargmann wrote:
> > Use gpio_is_valid instead of custom check.
> 
> Patches per driver please, this isn't just a mechanical transformation.

Okay, but you mean just patches 4 and 5 and not patch 2 right?

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/f6305cb0/attachment.sig>
