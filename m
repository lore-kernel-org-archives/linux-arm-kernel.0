From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 30 Jan 2013 16:05:36 +0000
Subject: Commit 384a290283fde63ba8dc671fca5420111cdac19a seems to break
 11MPCore boot
In-Reply-To: <alpine.LFD.2.02.1301301050230.6300@xanadu.home>
References: <51093B0B.7010708@arm.com>
 <alpine.LFD.2.02.1301301050230.6300@xanadu.home>
Message-ID: <1359561936.3094.19.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-01-30 at 16:00 +0000, Nicolas Pitre wrote:
> > Pawel suggested I try reverting 384a290283fde63ba8dc671fca5420111cdac19a -
> > "ARM: gic: use a private mapping for CPU target interfaces" that you've
> > authored. With this commit reverted the kernel boots.
> > 
> > I am not quite sure why the commit breaks 11MPCore but Pawel (cc'd) might be
> > able to shed light on that.
> 
> That would be appreciated as I don't have any good answer to provide.

Uh, I afraid that my light-generating capabilities may be slightly
overestimated, as it was just a logical but lucky guess, really.

> Typically, this patch highlighted problems with bad holding pen 
> implementations where secondary CPUs would enter the kernel all at the 
> same time. In that case the kernel was crashing even before displaying 
> "CPU2: Booted secondary processor".

I'll try to get the board and reproduce the problem, but I can't promise
any dates...

Pawe?
