From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 08 Feb 2011 15:43:14 -0500 (EST)
Subject: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
In-Reply-To: <78d0134576ace6be5874871076cf0c10@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<0557426516de482c1769a50fa0b5f17a@mail.gmail.com>
	<20110208164747.GD6188@n2100.arm.linux.org.uk>
	<78d0134576ace6be5874871076cf0c10@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1102081537010.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Feb 2011, Santosh Shilimkar wrote:

> > I think it's probably going to be better to _purposely_ break the 
> > OMAP build when it covers v6 and v7 CPUs in these kernels as I don't 
> > think it's sanely fixable given where we are.

Agreed.  At least making SMP unavailable when both v6 and v7 are 
configured should be small and good enough for 2.6.38-rc5.

> Any alternative possible other than breaking the omap2plus build?
> It's quite useful to have one build which covers majority of the
> omap machines.

Just merge this patch series in your testing tree, or create two configs 
(two builds) instead of only (a broken) one.

Or use linux-next for testing which would be even more beneficial.


Nicolas
