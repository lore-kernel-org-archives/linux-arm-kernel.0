From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 26 Jan 2010 10:25:32 +0100
Subject: S5PC100 squashing
In-Reply-To: <20100126083201.GZ10014@trinity.fluff.org>
References: <20100126083201.GZ10014@trinity.fluff.org>
Message-ID: <000001ca9e69$85087880$8f196980$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, January 26, 2010 9:32 AM Ben Dooks wrote:

> Does anyone have any opinion on whether plat-s5pc1xx should stay? At the
> moment it is only servicing mach-s5pc100 and thenew support for v210 and
> s5pc110 seem to be using plat-s5p and not plat-s5pc1xx.

I vote for moving s5pc100 support to plat-s5p directory and removing
plat-s5pc1xx dir completely. I want to prepare patches for this, but
waited until S5PV210 support gets merged.

> From the looks of it, s5pc100-init.c could probably be pushed into
> the arch/arm/mach-s5pc100/cpu.c file. The s5pc100-clock.c should be
> moved into arch/arm/mach-s5pc100/ as well.

Right.

> Not sure yet what to do with the rest.

Most of c100-specific code should be moved to mach-s5pc100 directory.
The rest can be probably shared with all S5P platforms. 

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
