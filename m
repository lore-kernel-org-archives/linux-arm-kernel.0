From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jul 2011 10:14:15 +0100
Subject: [PATCH 0/3] *** add lost UL suffix to VMALLOC_END ***
In-Reply-To: <1310093669-4681-1-git-send-email-bs14@csr.com>
References: <1310093669-4681-1-git-send-email-bs14@csr.com>
Message-ID: <20110708091415.GE2414@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 07:54:26PM -0700, Barry Song wrote:
> After grepping, several platforms lost the UL suffix for VMALLOC_END.
> 
> Barry Song (3):
>   ARM: CNS3XXX: add UL suffix to VMALLOC_END to ensure it is properly
>     typed
>   ARM: LPC32XXX: add UL suffix to VMALLOC_END to ensure it is properly
>     typed
>   ARM: NUC93X: add UL suffix to VMALLOC_END to ensure it is properly
>     typed

All looks fine to me, thanks.  Arnd - are you going to pick these up?
If so...

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

for all three.
