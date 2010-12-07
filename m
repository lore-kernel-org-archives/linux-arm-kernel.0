From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 7 Dec 2010 14:08:07 +0100
Subject: [PATCH 1/3] ARM: mx5: add support for the two watchdog modules
In-Reply-To: <AANLkTi=1ugnEX=f4Ko=d=7JWr5LZtTK+9L6ZWGt0Epth@mail.gmail.com>
References: <1291660714-16396-1-git-send-email-fabio.estevam@freescale.com>
	<20101207091613.GD21020@pengutronix.de>
	<AANLkTi=1ugnEX=f4Ko=d=7JWr5LZtTK+9L6ZWGt0Epth@mail.gmail.com>
Message-ID: <20101207130807.GF21020@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Tue, Dec 07, 2010 at 09:06:09AM -0200, Fabio Estevam wrote:
> 2010/12/7 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > On Mon, Dec 06, 2010 at 04:38:32PM -0200, Fabio Estevam wrote:
> >> MX51 has two watchdog modules.
> >>
> >> Add support for both of them.
> > I don't know why you need two watchdogs, but the patches look OK.
> 
> Can I get your Acked-by?
Yeah, you can consider that as an ack for the three patches in this
series.

> > Note there is a conflict between this patch series and the clk-change
> > for the watchdog driver.
> 
> Yes, I am aware of it. Probably the watchod driver patch I sent will
> go via the watchdog maintainer and when it gets applied I can fix the
> clocks for mx5 watchdog.
Hmm, maybe it's easier to let it go via Sascha's tree because it is more
likely to conflict with the changes there.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
