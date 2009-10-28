From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Oct 2009 16:35:53 +0000
Subject: Fix errata 411920
In-Reply-To: <20091024215313.GF16451@n2100.arm.linux.org.uk>
References: <20091024215313.GF16451@n2100.arm.linux.org.uk>
Message-ID: <1256747753.27121.60.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2009-10-24 at 21:53 +0000, Russell King - ARM Linux wrote:
> Here's a patch which addresses the remaining operations.  Note that
> the arch/arm/mm/context.c one is weird - it's flushing the BTB
> twice - once using "c7, c5, 0" and again with "c7, c5, 6".  Is there
> a a reason for this?

I replied to the patch series as well. I don't think we need the BTB
flushing here.

-- 
Catalin
