From: r.herring@freescale.com (Rob Herring)
Date: Fri, 23 Apr 2010 16:02:25 -0500
Subject: [RFC PATCH 08/10] imx: Add MX53 core support
In-Reply-To: <20100423193709.GB18310@pengutronix.de>
References: <1271446524-26450-9-git-send-email-r.herring@freescale.com>
	<20100423193709.GB18310@pengutronix.de>
Message-ID: <1272056545.20896.58.camel@ra7055-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe,

On Fri, 2010-04-23 at 12:37 -0700, Uwe Kleine-K?nig wrote:
> all in all this looks like a sort of minimal change to make it work
> (which is good), but it destroys the efforts spend in the past to use
> proper name spaces and have understandable, modular and easy code.  So
> according to my preferences about how to program the patch is wrong.
> 
Thanks for you comments. The minimal change was the whole point and why
it is just RFC. I wanted input before going any further. It seems a bit
pointless to me to create devices-mx53.c, clock-mx53.c, etc. all for a
simple shift in register base.

Rob
