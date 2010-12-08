From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 8 Dec 2010 10:14:38 +0100
Subject: [PATCH v2 04/15] ARM: mxs: Add interrupt support
In-Reply-To: <AANLkTim4i1fo1ebKxONeu79-AMXevyhhqh-uV26Yb2aK@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-3-git-send-email-shawn.guo@freescale.com>
	<20101207210352.GC14775@pengutronix.de>
	<AANLkTim4i1fo1ebKxONeu79-AMXevyhhqh-uV26Yb2aK@mail.gmail.com>
Message-ID: <20101208091438.GE18244@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Wed, Dec 08, 2010 at 04:56:40PM +0800, Shawn Guo wrote:
> 2010/12/8 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> [...]
> >> +
> >> + ? ? .macro ?disable_fiq
> >> + ? ? .endm
> > I think is isn't needed. ?Only when you start to actually use the fiq.
> >
> Without it, the compiler will complain when compiling
> arch/arm/kernel/entry-armv.S.
OK
 
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
