From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 20 Dec 2010 11:48:12 +0000
Subject: [PATCHv3 1/4] mc13xxx-core: Consolidate common code to prepare
	for separate i2c and spi
In-Reply-To: <201012202100.29212.marc@cpdesign.com.au>
References: <1292817055-17715-1-git-send-email-marc@cpdesign.com.au>
	<1292817055-17715-2-git-send-email-marc@cpdesign.com.au>
	<20101220083120.GP1940@pengutronix.de>
	<201012202100.29212.marc@cpdesign.com.au>
Message-ID: <20101220114811.GA14986@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 20, 2010 at 09:00:29PM +1100, Marc Reilly wrote:
> On Monday, December 20, 2010 07:31:20 pm Uwe Kleine-K?nig wrote:

> > This list isn't complete, but see below.

> Do you mean the list above is incomplete? I should have said "Changes to the 
> struct _include_". 
> I'm ignorant of "patch summary etiquette" (or what people otherwise like to 
> see) but I had just assumed that the patch comments were more like a 
> highlights reel - the real info is in the patch itself.

No, the patch summary should generally be complete - if your patch is
changing so many things that it's getting tedious to list them all then
that's usually a sign that it should be split up into a series of
changes.
