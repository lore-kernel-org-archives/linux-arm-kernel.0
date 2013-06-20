From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Jun 2013 11:11:10 +0100
Subject: [RFC 0/3] How to pass IOMMU map attr via DMA API?
In-Reply-To: <20130620.125929.2250094502232662356.hdoyu@nvidia.com>
References: <1371707384-30037-1-git-send-email-hdoyu@nvidia.com>
 <20130620093152.GE2842@mudshark.cambridge.arm.com>
 <20130620.125929.2250094502232662356.hdoyu@nvidia.com>
Message-ID: <20130620101110.GB18536@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 10:59:29AM +0100, Hiroshi Doyu wrote:
> Hi Will,
> 
> Will Deacon <will.deacon@arm.com> wrote @ Thu, 20 Jun 2013 11:31:52 +0200:
> 
> > > Hiroshi Doyu (3):
> > >   common: DMA-mapping: add DMA_ATTR_READ_ONLY attribute
> > >   ARM: dma-mapping: Pass DMA attrs as IOMMU prot
> > >   iommu/tegra: smmu: Support read-only mapping
> > 
> > These patches don't seem to have made it to the linux-arm-kernel list
> > (either in my inbox or the list archive). Could you try and resend them please?
> 
> I'm sorry but linux-arm-kernel list someitmes requires me moderators
> approval. I don't know why. I'll find a way to work around.

I guess it doesn't like the threading. It works better if you have
"[PATCH" in the subject.

-- 
Catalin
