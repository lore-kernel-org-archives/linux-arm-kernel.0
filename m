From: tony@atomide.com (Tony Lindgren)
Date: Mon, 15 Oct 2012 09:01:55 -0700
Subject: [PATCH 0/4] OMAP-GPMC generic timing migration
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9FCEC9@DBDE01.ent.ti.com>
References: <cover.1349450723.git.afzal@ti.com> <5076B166.2020006@gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9FBC41@DBDE01.ent.ti.com>
 <20121011144756.GB12552@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9FCEC9@DBDE01.ent.ti.com>
Message-ID: <20121015160154.GB15569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mohammed, Afzal <afzal@ti.com> [121015 05:42]:
> Hi Tony,
> 
> On Thu, Oct 11, 2012 at 20:17:56, Tony Lindgren wrote:
> > * Mohammed, Afzal <afzal@ti.com> [121011 05:48]:
> 
> > After -rc1 is out, let's plan on adding the minimal
> > set required for removing plat and mach includes from
> > drivers into a clean-up branch. Afzal, can you maybe
> > do a pull request for that set against -rc1 when it's
> > out? Just the minimal set of patches.
> 
> Pull request on gpmc cleanup for common ARM zImage has
> been sent.

Thanks.
 
> > Yes, then please do a second pull request for what's needed
> > to apply the minimal DT bindings. For the DT binding, let's
> > just leave out the timings for now as we can load those from
> > auxdata. Then the binding for the timings can be added
> > later on. So just the minimal binding using standard features
> > for the iorange and interrupt.
> 
> Ok, I will keep timings aside for now and proceed with DT
> (avoiding auxdata usage with generic routine looked to me a
> saner approach though, with an initial DT'fy delay)

Oh well if you think it's easier to do the timings too in
the DT binding, please go ahead with that. It may take some
longer discussion on the lists for the binding though. But
up to you.

Regards,

Tony
