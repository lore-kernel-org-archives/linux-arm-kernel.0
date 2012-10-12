From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 12 Oct 2012 15:36:13 +0100
Subject: alignment faults in 3.6
In-Reply-To: <20121012142254.GG5453@kvack.org>
References: <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <AE90C24D6B3A694183C094C60CF0A2F6026B703E@saturn3.aculab.com>
 <yw1xtxu1nfsn.fsf@unicorn.mansr.com> <201210120811.43290.arnd@arndb.de>
 <20121012090321.GA21164@n2100.arm.linux.org.uk>
 <yw1xhaq0nefg.fsf@unicorn.mansr.com>
 <20121012110750.GE21164@n2100.arm.linux.org.uk>
 <yw1x8vbcndlb.fsf@unicorn.mansr.com>
 <20121012114443.GG21164@n2100.arm.linux.org.uk>
 <1350043692.21172.11815.camel@edumazet-glaptop>
 <20121012142254.GG5453@kvack.org>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B703F@saturn3.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> x86 does have an alignment check flag that can be set in the flags register.
> Somehow, I doubt anyone would be willing to walk through all the noise the
> faults would likely trigger.

Someone has tried to set that (in userspace) on NetBSD.
The fault reporting has been fixed, but really nothing
works since optimised parts of libc deliberately do
misaligned transfers.

	David
