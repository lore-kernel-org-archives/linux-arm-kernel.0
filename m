From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Jul 2011 17:54:21 +0200
Subject: [PATCH 0/3] *** add lost UL suffix to VMALLOC_END ***
In-Reply-To: <20110708091415.GE2414@n2100.arm.linux.org.uk>
References: <1310093669-4681-1-git-send-email-bs14@csr.com>
	<20110708091415.GE2414@n2100.arm.linux.org.uk>
Message-ID: <201107081754.22072.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 July 2011, Russell King - ARM Linux wrote:
> On Thu, Jul 07, 2011 at 07:54:26PM -0700, Barry Song wrote:
> > After grepping, several platforms lost the UL suffix for VMALLOC_END.
> > 
> > Barry Song (3):
> >   ARM: CNS3XXX: add UL suffix to VMALLOC_END to ensure it is properly
> >     typed
> >   ARM: LPC32XXX: add UL suffix to VMALLOC_END to ensure it is properly
> >     typed
> >   ARM: NUC93X: add UL suffix to VMALLOC_END to ensure it is properly
> >     typed
> 
> All looks fine to me, thanks.  Arnd - are you going to pick these up?
> If so...
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Applied to arm-soc/next/fixes, thanks!

	Arnd
