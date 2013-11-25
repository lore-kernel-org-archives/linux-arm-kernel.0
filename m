From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 25 Nov 2013 22:13:47 +0100
Subject: [PATCH] ARM: u300: fix timekeeping when periodic mode is used
In-Reply-To: <CACRpkdZrV7fPcyNeBdzhhZHDkm1ZmixwDi=1=vKnFOBiYTQYsw@mail.gmail.com>
References: <20131105083336.GK14892@pengutronix.de>
 <1383642199-11473-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdZrV7fPcyNeBdzhhZHDkm1ZmixwDi=1=vKnFOBiYTQYsw@mail.gmail.com>
Message-ID: <20131125211347.GD28642@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 10:44:58AM +0100, Linus Walleij wrote:
> On Tue, Nov 5, 2013 at 10:03 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > To determine the value to write to the hardware's timer counter register
> > the symbol CLOCK_TICK_RATE is used. This value is a dummy value on u300
> > though. So instead use the clock rate that is used for oneshot mode.
> >
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Thanks, patch applied to the u300 branch in the linux-stericsson
> tree.
This isn't in next? At least this patch doesn't appear there.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
