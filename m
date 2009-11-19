From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 19 Nov 2009 18:54:27 +0000
Subject: [alsa-devel] i.MX audio support
In-Reply-To: <20091119175327.GV30179@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<20091119162830.GA31336@rakim.wolfsonmicro.main>
	<20091119175327.GV30179@pengutronix.de>
Message-ID: <20091119185426.GA2814@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 06:53:27PM +0100, Sascha Hauer wrote:

> My work isn't based on the mainline driver but some older (also
> Freescale based) code. Putting this into an incremental series would
> mean quite some work.

That's not really my point - my point is that one way or another the new
code needs to update the existing code.  I don't want to end up in a
situation where we have two different drivers in mainline since that
will create user confusion and a greater maintinence burden.  I'm not so
fussed about how exactly that is achieved.
