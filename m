From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 10 Apr 2012 14:53:00 +0200
Subject: [PATCHv8 03/10] ARM: dma-mapping: introduce ARM_DMA_ERROR constant
In-Reply-To: <201204101131.56412.arnd@arndb.de>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
 <1334055852-19500-4-git-send-email-m.szyprowski@samsung.com>
 <201204101131.56412.arnd@arndb.de>
Message-ID: <002c01cd1718$dc852660$958f7320$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tuesday, April 10, 2012 1:32 PM Arnd Bergmann wrote:

> On Tuesday 10 April 2012, Marek Szyprowski wrote:
> > Replace all uses of ~0 with ARM_DMA_ERROR, what should make the code
> > easier to read.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> I like the idea, but why not name this DMA_ERROR_CODE like the other
> architectures do? I think in the long run we should put the definition
> into a global header file.

Ok, no problem, I will unify it with other architectures.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
