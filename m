From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 26 May 2010 08:58:32 -0700
Subject: [PATCH 1/2] mc13783: add LED support
In-Reply-To: <1274875268.24079.1.camel@rex>
References: <1274114423-30020-1-git-send-email-philippe.retornaz@epfl.ch>
	<1274114423-30020-2-git-send-email-philippe.retornaz@epfl.ch>
	<20100517190242.GA17604@pengutronix.de>
	<20100517200017.GA25262@sirena.org.uk>
	<1274875268.24079.1.camel@rex>
Message-ID: <20100526155831.GA18834@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 01:01:08PM +0100, Richard Purdie wrote:
> On Mon, 2010-05-17 at 21:00 +0100, Mark Brown wrote:

> > It'd be nice to add helpers for this to the LED core, there's quite a
> > few drivers implementing this idiom now - a flag that does the deferring
> > of the set() for example.

> Agreed, or a wrapper around the core which deferred implementations
> could just use. I'm open to patches :)

In my copious free time, perhaps.  I was kind of hoping someone actively
working on a driver could be inspired to do the work :)
