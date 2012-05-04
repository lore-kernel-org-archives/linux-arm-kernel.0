From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 4 May 2012 23:16:55 +0200
Subject: [PATCH 00/02] mach-shmobile: Emma Mobile EV2 - first shot
In-Reply-To: <201205041957.14205.arnd@arndb.de>
References: <20120503144645.6390.62303.sendpatchset@w520>
 <201205041957.14205.arnd@arndb.de>
Message-ID: <201205042316.55593.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 04, 2012, Arnd Bergmann wrote:
> On Thursday 03 May 2012, Magnus Damm wrote:
> > mach-shmobile: Emma Mobile EV2 - first shot
> > 
> > [PATCH 01/02] mach-shmobile: Emma Mobile EV2 SoC base support
> > [PATCH 02/02] mach-shmobile: KZM9D board prototype support
> > 
> > This series adds experimental Emma Mobile EV2 support to
> > mach-shmobile. Yet another dual core Cortex-A9 SoC.
> > 
> > At this point only serial and timer is supported. Future work
> > includes GPIO, network device, SMP and DT support. If possible
> > it would be nice to use the common clocks on this platform.
> > 
> > To boot this on actual hardware you also need the following:
> > "[PATCH] serial8250-em: Emma Mobile UART driver V2"
> > "[PATCH] clocksource: em_sti: Emma Mobile STI driver"
> > 
> > Any reason to not put this in mach-shmobile?
> 
> Well, from all I can tell it shares basically zero code with the
> rest of mach-shmobile, so I would be more comfortable with creating
> a new mach-emma directory for this.

I'm not sure if I understand your point correctly, so please let me clarify.

Do you think it's better to have a separate mach-emma directory for the
new hardware because technically it is a different platform and the fact
that it was developed by the same manufacturer as the mach-shmobile hardware
is less important?

Rafael
