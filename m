From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Jul 2010 11:19:44 +0100
Subject: LMB build failure in -next
In-Reply-To: <20100716095949.GJ9082@rakim.wolfsonmicro.main>
References: <20100716094151.GI9082@rakim.wolfsonmicro.main>
	<20100716095418.GB17952@n2100.arm.linux.org.uk>
	<20100716095949.GJ9082@rakim.wolfsonmicro.main>
Message-ID: <20100716101944.GC17952@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 10:59:50AM +0100, Mark Brown wrote:
> On Fri, Jul 16, 2010 at 10:54:18AM +0100, Russell King - ARM Linux wrote:
> 
> > Ben asked Linus to pull his LMB updates, which renamed all the LMB
> > infrastructure to memblock.  I'll have to rebase the LMB branch -
> > possibly later today.
> 
> Ah, right - so long as the problem is known and will be sorted it's not
> a problem, I just hadn't seen any reports.  Thanks!

I've now pushed out a new copy of my tree with the LMB stuff rebased
and renamed appropriately.
