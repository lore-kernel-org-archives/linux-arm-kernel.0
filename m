From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 27 Nov 2015 10:40:45 +0300
Subject: PING-2: [PATCH v4 TRIVIAL 1/2] ARM: Enable GICv2m on 32-bit virt
 machine
Message-ID: <005001d128e6$ed51b880$c7f52980$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> > The generic MSI domain (which is what asm-generic/msi.h is about -
> > nothing GIC specific about it) is entirely isolated from the rest of the
> > MSI infrastructure used on 32bit ARM, and is very unlikely to introduce
> > any regression.
> 
> That's good to hear.  Okay, let's get this patch in the patch system then,
> and I'll see whether it has any effect on Armada 388.

 I am reviewing current status of my patches, and there are no news about this one so far. I have checked the patch system several
times and i was never able to find this patch in it. Are there any known problems?

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
