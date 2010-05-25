From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 25 May 2010 09:55:21 +0200
Subject: [PATCH 01/16] arm/mx3: rename mach-mx35pdk.c to
	mach-mx35_3ds.c matching its arch number
In-Reply-To: <663004.37933.qm@web51008.mail.re2.yahoo.com>
Message-ID: <20100525075521.GA11542@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Mon, May 24, 2010 at 03:20:59PM -0700, Fabio Estevam wrote:
> --- On Mon, 5/24/10, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> 
> > From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Subject: [PATCH 01/16] arm/mx3: rename mach-mx35pdk.c to mach-mx35_3ds.c matching its arch number
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: kernel at pengutronix.de
> > Date: Monday, May 24, 2010, 4:55 PM
> > Additional document all known names
> > of that machine.
> ...
> 
> To make it consistent across other i.MX boards: shouldn't
> mach-mx5/board-mx51_babbage.c be also renamed?
IMHO yes, but Amit considered "board" to be better than "mach", so I
dropped that.  The longer term plan is to consolidate all imx platforms
in a single directory.  For that all files need to be touched anyhow and
then I would discuss this again.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
