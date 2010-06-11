From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 11 Jun 2010 16:11:41 +0200
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <20100611095839.GC10894@pengutronix.de>
References: <1275636608.606606.450179637764.0.gpush@pororo>
	<201006111557.12249.jeremy.kerr@canonical.com>
	<19473.61547.684572.647641@ipc1.ka-ro>
	<201006111718.47426.jeremy.kerr@canonical.com>
	<19474.172.742782.972629@ipc1.ka-ro>
	<20100611095839.GC10894@pengutronix.de>
Message-ID: <20100611141141.GE10894@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lothar,

On Fri, Jun 11, 2010 at 11:58:39AM +0200, Uwe Kleine-K?nig wrote:
> > You are probably talking about the Freescale i.MX51 kernel, that won't
> > even boot, if you enable CONFIG_DEBUG_KERNEL, CONFIG_DEBUG_SPINLOCK,
> > CONFIG_DEBUG_LOCKDEP and CONFIG_DEBUG_SPINLOCK_SLEEP.
> > The mutex in the clock implementation is one of the reasons.
> I will have a look into this later today.
I take this back as this is not a mainline problem.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
