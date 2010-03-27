From: hjk@linutronix.de (Hans J. Koch)
Date: Sat, 27 Mar 2010 17:20:29 +0100
Subject: [PATCH 2/7 v2] Add clock framework for plat-tcc
In-Reply-To: <20100325203242.GC24984@n2100.arm.linux.org.uk>
References: <20100325200427.GC2047@bluebox.local>
	<20100325200915.GE2047@bluebox.local>
	<20100325203242.GC24984@n2100.arm.linux.org.uk>
Message-ID: <20100327162029.GC2035@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 08:32:42PM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 25, 2010 at 09:09:16PM +0100, Hans J. Koch wrote:
> > +#define BCLKCTR0	(void __iomem *)(CKC_BASE + BCLKCTR0_OFFS)
> > +#define BCLKCTR1	(void __iomem *)(CKC_BASE + BCLKCTR1_OFFS)
> 
> If you define CKC_BASE to have type 'void __iomem *' then all these
> cases go away.

Done.

> 
> > +	reg = __raw_readl(CKC_BASE + CLKCTRL_OFFS);
> 
> And this won't warn in the future.

Right :)

Thanks,
Hans
