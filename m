From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Sat, 29 Jan 2011 17:41:30 +0530
Subject: [PATCH-V2] OMAP3EVM:FIX: Reset the smsc911x ethernet controller
	in board_init
In-Reply-To: <87d3nikt3j.fsf@ti.com>
References: <1295968956-10166-1-git-send-email-hvaibhav@ti.com>
	<19F8576C6E063C45BE387C64729E739404BD7BE3F4@dbde02.ent.ti.com>
	<87d3nikt3j.fsf@ti.com>
Message-ID: <19F8576C6E063C45BE387C64729E739404BD7BEB5C@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Hilman, Kevin
> Sent: Friday, January 28, 2011 1:38 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap at vger.kernel.org; Varadarajan, Charulatha; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH-V2] OMAP3EVM:FIX: Reset the smsc911x ethernet
> controller in board_init
> 
> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> 
> >> -----Original Message-----
> >> From: Hiremath, Vaibhav
> >> Sent: Tuesday, January 25, 2011 8:53 PM
> >> To: linux-omap at vger.kernel.org
> >> Cc: Hiremath, Vaibhav; Varadarajan, Charulatha
> >> Subject: [PATCH-V2] OMAP3EVM:FIX: Reset the smsc911x ethernet
> controller
> >> in board_init
> >>
> >> With addition of hwmod support to gpio, the ethernet controller
> >> goes undetected for OMAP35xEVM. So explicitly assert the reset signal
> to
> >> ethernet controller smsc911x -
> >>
> >> 	- GPIO7 (>=RevG version of EVM's)
> >> 	- GPIO64 (<=RevD version of EVM's)
> >>
> >> This patch is based on intial version from Charulatha V, reference
> >> to original discussion -
> >> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg35784.html
> >> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> >> Signed-off-by: Charulatha V <charu@ti.com>
> >> Tested-by: Kevin Hilman <khilman@ti.com>
> >> ---
> >> Since Kevin reported that this patch doesn't get applied cleanly,
> >> so I am reposting it again after making sure that it gets applied
> cleanly.
> >>
> > [Hiremath, Vaibhav] Oops, missed linux-arm-kernel list, adding here.
> >
> > Not sure whether I need to repost keeping linux-arm-kernel?
> >
> 
> Also, did you post the smc911x driver fix yet that is needed for testing
> with newer kernels?
> 
[Hiremath, Vaibhav] Not yet. Got completely loaded with some high priority issues. I will try to post it sometime this week.

Thanks,
Vaibhav

> Kevin
