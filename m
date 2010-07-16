From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Jul 2010 10:54:18 +0100
Subject: LMB build failure in -next
In-Reply-To: <20100716094151.GI9082@rakim.wolfsonmicro.main>
References: <20100716094151.GI9082@rakim.wolfsonmicro.main>
Message-ID: <20100716095418.GB17952@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 10:41:51AM +0100, Mark Brown wrote:
> In -next the patch 'ARM: initial LMB trial' is causing build failures:
> 
>   CHECK   arch/arm/kernel/setup.c
> arch/arm/kernel/setup.c:30:11: error: unable to open 'linux/lmb.h'
> 
> for me.  Looks like the generic header got missed from the commit or
> there's some other tree that also needs to be in -next?

Ben asked Linus to pull his LMB updates, which renamed all the LMB
infrastructure to memblock.  I'll have to rebase the LMB branch -
possibly later today.
