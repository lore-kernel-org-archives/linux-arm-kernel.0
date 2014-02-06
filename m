From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Feb 2014 10:29:09 +0000
Subject: [PATCH] arm64: Change misleading function names in dma-mapping
In-Reply-To: <20140206100909.GC26035@mudshark.cambridge.arm.com>
References: <CAD15agZzJ4=RMbky+GymJbyktLz0PO+uZ-GOh1SbvH476k4hzA@mail.gmail.com>
 <20140206100909.GC26035@mudshark.cambridge.arm.com>
Message-ID: <20140206102909.GA29446@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 10:09:09AM +0000, Will Deacon wrote:
> On Thu, Feb 06, 2014 at 06:28:22AM +0000, Ritesh Harjani wrote:
> > 
> > From: Ritesh Harjani <ritesh.harjani at gmail.com<mailto:ritesh.harjani@gmail.com>>
> > 
> > arm64_swiotlb_alloc/free_coherent name can be misleading
> > somtimes with CMA support being enabled after this
> > patch (c2104debc235b745265b64d610237a6833fd53)
> > 
> > Change this name to be more generic:
> > arm64_dma_alloc/free_coherent
> 
> I'm fine with this cosmetic change, but the (pre-existing) arm64 prefix looks
> a little odd for a static function.

Good point. I'm happy with a simpler __dma_alloc_coherent().

-- 
Catalin
