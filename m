From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 30 Nov 2010 14:55:17 +0000
Subject: [PATCH] make mc13783 code generic
In-Reply-To: <20101130143247.GI20449@pengutronix.de>
References: <AANLkTimfDHRXZjB5=Ld9YSFzqh-hVWUTy-TQFV=GEaGA@mail.gmail.com>
	<1291110118.3235.27.camel@realization>
	<20101130143247.GI20449@pengutronix.de>
Message-ID: <20101130145517.GF32368@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 03:32:47PM +0100, Uwe Kleine-K?nig wrote:
> On Tue, Nov 30, 2010 at 10:41:58AM +0100, Alberto Panizzo wrote:

> > PS: ./scripts/get_maintainer.pl said to cc all these guys:

> > Please, use always this script to decide who have to be cc'ed by default
> > sending patches.

> No, please don't.  Better use your common sense.  get_maintainer.pl is a
> hint at best.  E.g. Axel Lin only shows up in the list, because he
> touched several other regulator drivers and drivers/regulator/Makefile.
> I doubt that this is enough to imply interest.

Yeah, Axel is doing a lot of cleanups but he's not got an active
interest in most of the code he's touching.  If you use the --nogit
option (which is the default with current -next) get_maintainer.pl is a
bit safer but you then need to think about people who might be actively
interested in the driver but not listed in MAINTAINERS, and you still
need to make sure that everyone you're seeing is interested (especially
with multi-level maintianance).
