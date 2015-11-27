From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Nov 2015 08:55:20 +0000
Subject: PING-2: [PATCH v4 TRIVIAL 1/2] ARM: Enable GICv2m on 32-bit
 virt machine
In-Reply-To: <005001d128e6$ed51b880$c7f52980$@samsung.com>
References: <005001d128e6$ed51b880$c7f52980$@samsung.com>
Message-ID: <20151127085520.4d94c738@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Nov 2015 10:40:45 +0300
Pavel Fedin <p.fedin@samsung.com> wrote:

>  Hello!
> 
> > > The generic MSI domain (which is what asm-generic/msi.h is about -
> > > nothing GIC specific about it) is entirely isolated from the rest of the
> > > MSI infrastructure used on 32bit ARM, and is very unlikely to introduce
> > > any regression.
> > 
> > That's good to hear.  Okay, let's get this patch in the patch system then,
> > and I'll see whether it has any effect on Armada 388.
> 
>  I am reviewing current status of my patches, and there are no news
> about this one so far. I have checked the patch system several times
> and i was never able to find this patch in it. Are there any known
> problems?

The problem is that you never put it in the patch system, so it never
went anywhere.

0ab089c solved part of it, so you may want to post the required delta
and put it in the patch system.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
