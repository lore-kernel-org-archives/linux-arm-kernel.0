From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 6 Sep 2011 21:42:53 +0200
Subject: [PATCH 0/6] add initial imx6q support
In-Reply-To: <2043782.jegSLqAsTH@wuerfel>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<2043782.jegSLqAsTH@wuerfel>
Message-ID: <20110906194253.GO28816@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Tue, Sep 06, 2011 at 08:28:39PM +0200, Arnd Bergmann wrote:
> We've talked about it before, but I don't remember the outcome. Can you
> explain (and add to the above text) a short explanation of why this is
> in the mach-imx directory, rather than the mach-mx5 (which probably is
> closer to mx6 than mx3 is) or a new mach-mx6?
Not having looked into the patches yet, but I think mach-imx is the
right choice. The longterm plan for mach-mx5 is to be folded into
mach-imx, too. We just didn't found a volunteer for that.

Best regards
Uwe

BTW, are you on irc somewhere?

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
