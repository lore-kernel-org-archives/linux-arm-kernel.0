From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Aug 2010 15:06:23 +0300
Subject: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
In-Reply-To: <20100819102025.GA32151@n2100.arm.linux.org.uk>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	<20100817135205.GC20325@n2100.arm.linux.org.uk>
	<20100817141210.GJ12184@atomide.com>
	<20100817154035.GD20325@n2100.arm.linux.org.uk>
	<20100819073810.GR12184@atomide.com>
	<4C6CFBAF.6020407@canonical.com>
	<20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
Message-ID: <20100820120622.GL25742@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100819 13:13]:
> On Thu, Aug 19, 2010 at 12:57:06PM +0300, Tony Lindgren wrote:
> > Looks like something is not quite right with smp_on_up part of __fixup_smp,
> > returning early before smp_on_up does not produce that.
> 
> It's probably overwriting some register it shouldn't be.  I might be
> able to look at this sometime during the coming week... assuming that
> the weather is as bad as they forecast and I have 'net connectivity.

OK, I'll be offline too probably until late next week.

Tony
