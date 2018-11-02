From: hch@lst.de (Christoph Hellwig)
Date: Fri, 2 Nov 2018 19:26:49 +0100
Subject: Warnings in arch/arm64/mm/dma-mapping.c
In-Reply-To: <20181102174723.GI218059@arrakis.emea.arm.com>
References: <a771d5ce-28a2-609e-5fd7-338fadc20743@gmail.com>
 <20181030074344.GA24697@lst.de> <20181030101342.GC19955@arm.com>
 <20181102174723.GI218059@arrakis.emea.arm.com>
Message-ID: <20181102182649.GA11085@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2018 at 05:47:24PM +0000, Catalin Marinas wrote:
> On Tue, Oct 30, 2018 at 10:13:42AM +0000, Will Deacon wrote:
> > On Tue, Oct 30, 2018 at 08:43:44AM +0100, Christoph Hellwig wrote:
> > > On Mon, Oct 29, 2018 at 04:51:47PM -0700, Florian Fainelli wrote:
> > > > I have not a chance to run a bisection yet, but I suspect this is coming
> > > > from Christoph's latest batch of DMA-API changes in ARM64 under the
> > > > merge commit befa93633193e5327e4045d1e5fa29114580fa5d ("Merge tag
> > > > 'dma-mapping-4.20-1' of git://git.infradead.org/users/hch/dma-mapping"),
> > > > here are the warnings:
> > > 
> > > This should fix it:
> > 
> > Tested-by: Will Deacon <will.deacon@arm.com>
> > 
> > I guess Catalin can pick this up for -rc1, since there's also the kprobes
> > RO fix kicking around for arm64?
> 
> I can pick it up at -rc1 as I don't have Christoph's patches in my tree
> (and don't want to base a branch on some random point in the merging
> window).
> 
> Alternatively, it could go via Christoph's tree for -rc1.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I'll send it on tomorrow.
