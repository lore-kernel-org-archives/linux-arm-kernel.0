From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Dec 2010 10:01:38 +0000
Subject: [PATCHv3] support PMIC mc13892
In-Reply-To: <20101208091226.GD18244@pengutronix.de>
References: <1291778460-22819-1-git-send-email-yong.shen@freescale.com>
	<1291778460-22819-2-git-send-email-yong.shen@freescale.com>
	<20101208091226.GD18244@pengutronix.de>
Message-ID: <20101208100138.GB16418@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 10:12:26AM +0100, Uwe Kleine-K?nig wrote:

Please cut unneded context - it makes it much easier to find the new
text in your replies!

> > +	if (ret)
> > +		goto err_alloc;

> err_alloc seems wrong.  The goto is taken when reading the revision
> register fails, not on a failed allocation.

His code is following the style of naming the exit points after what
needs to be unwound rather than after the place jumped from which is
common enough?

> > +#define MC13892_PWGT1SPI	21
> > +#define MC13892_PWGT2SPI	22
> > +#define MC13892_VCOINCELL	23

> I thought you wanted to put these somewhere below drivers/regulator/.

Please.
