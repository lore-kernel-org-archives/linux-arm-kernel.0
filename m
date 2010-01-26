From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 26 Jan 2010 11:59:04 +0000
Subject: whoever is using ymiao3@marvell.com please stop it
In-Reply-To: <20100126113534.GF20792@pengutronix.de>
References: <20100125014024.GA4609@trinity.fluff.org>
	<f17812d71001251730p4747199bhd4176d5835073b56@mail.gmail.com>
	<20100126052317.GY10014@trinity.fluff.org>
	<20100126113534.GF20792@pengutronix.de>
Message-ID: <20100126115903.GB32291@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 12:35:34PM +0100, Uwe Kleine-K?nig wrote:

> I'd suggest to check if the address is listed in .mailmap and use the
> first entry for that person.  This would need some work to adapt
> .mailmap, as .mailmap mainly collects wrong entries.

This breaks when you get multiple people with the same name - I'm not
the only Mark Brown for example (though I don't think any others are
actually contributing patches).  It'd be better to add an explicit mail
address rewriting feature (.forward?).
