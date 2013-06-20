From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 20 Jun 2013 13:00:48 +0200
Subject: [RFC 0/3] How to pass IOMMU map attr via DMA API?
In-Reply-To: <20130620101110.GB18536@arm.com>
References: <20130620093152.GE2842@mudshark.cambridge.arm.com><20130620.125929.2250094502232662356.hdoyu@nvidia.com><20130620101110.GB18536@arm.com>
Message-ID: <20130620.140048.660909250426165627.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas@arm.com> wrote @ Thu, 20 Jun 2013 12:11:10 +0200:

> On Thu, Jun 20, 2013 at 10:59:29AM +0100, Hiroshi Doyu wrote:
> > Hi Will,
> > 
> > Will Deacon <will.deacon@arm.com> wrote @ Thu, 20 Jun 2013 11:31:52 +0200:
> > 
> > > > Hiroshi Doyu (3):
> > > >   common: DMA-mapping: add DMA_ATTR_READ_ONLY attribute
> > > >   ARM: dma-mapping: Pass DMA attrs as IOMMU prot
> > > >   iommu/tegra: smmu: Support read-only mapping
> > > 
> > > These patches don't seem to have made it to the linux-arm-kernel list
> > > (either in my inbox or the list archive). Could you try and resend them please?
> > 
> > I'm sorry but linux-arm-kernel list someitmes requires me moderators
> > approval. I don't know why. I'll find a way to work around.
> 
> I guess it doesn't like the threading. It works better if you have
> "[PATCH" in the subject.

It seems to work. I did with "[PATCH" and --no-thread. Thanks.
