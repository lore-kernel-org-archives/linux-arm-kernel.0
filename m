From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 12 Feb 2010 11:35:38 +0100
Subject: [PATCH 1/2] arm/at91: Don't disable irqs in set_next_event and
	set_mode callbacks
In-Reply-To: <20100122165238.GB13718@pengutronix.de>
References: <1259231164-21242-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1261056821-28521-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100122160824.GA13718@pengutronix.de>
	<20100122163658.GA18461@n2100.arm.linux.org.uk>
	<20100122165238.GB13718@pengutronix.de>
Message-ID: <20100212103538.GA6590@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Fri, Jan 22, 2010 at 05:52:38PM +0100, Uwe Kleine-K?nig wrote:
> On Fri, Jan 22, 2010 at 04:36:58PM +0000, Russell King - ARM Linux wrote:
> > On Fri, Jan 22, 2010 at 05:08:24PM +0100, Uwe Kleine-K?nig wrote:
> > > You can pull them from
> > > 
> > > 	git://git.pengutronix.de/git/ukl/linux-2.6.git arm/clock-event
> > 
> > I really don't like pulling git urls which I don't know what I'm pulling.
> > Please include at least a diffstat and shortlog of the commits you're
> > expecting to be sent.
> > 
> > Something like the output from git request-pull would be ideal.
> OK, appended below.  Actually I expected you to make me sending them to
> the patch system.  But as I prefer when you pull from me, I'm happy to
> provide you with diffstat and shortlog.
You didn't pull yet.  Is this still on your list?


Best regards
Uwe

> The following changes since commit 066000dd856709b6980123eb39b957fe26993f7b:
>   Ananth N Mavinakayanahalli (1):
>         Revert "x86, apic: Use logical flat on intel with <= 8 logical cpus"
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/ukl/linux-2.6.git arm/clock-event
> 
> Uwe Kleine-K?nig (2):
>       arm/at91: Don't disable irqs in set_next_event and set_mode callbacks
>       arm/{pxa,sa1100,nomadik}: Don't disable irqs in set_next_event and set_mode
> 
>  arch/arm/mach-at91/at91rm9200_time.c  |   20 ++++++--------------
>  arch/arm/mach-at91/at91sam926x_time.c |   11 ++++++-----
>  arch/arm/mach-pxa/time.c              |   10 +---------
>  arch/arm/mach-sa1100/time.c           |    8 +-------
>  arch/arm/plat-nomadik/timer.c         |    9 +--------
>  5 files changed, 15 insertions(+), 43 deletions(-)

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
