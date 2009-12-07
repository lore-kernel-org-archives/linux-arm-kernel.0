From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 07 Dec 2009 13:46:12 +0000
Subject: dma_cache_maint_contiguous should be patched as dma_cache_maint do
In-Reply-To: <1260188011.18974.38.camel@pc1117.cambridge.arm.com>
References: <1260188011.18974.38.camel@pc1117.cambridge.arm.com>
Message-ID: <1260193572.18974.43.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-12-07 at 12:13 +0000, Catalin Marinas wrote:
> On Mon, 2009-12-07 at 03:13 +0000, mkl lin wrote:
> > I had had an issue on USB data read, which is often incorrect. With
> > the help of this ML and some luck, I think the following patch that
> > patch dma_cache_maint should be applied t dma_cache_maint_contiguous,
> > which is called by dma_cache_maint_page.
> >
> > Broadcast the DMA cache operations on ARMv6 SMP hardware
> > http://linux-arm.org/git?p=linux-2.6.git;a=commitdiff;h=f1c242dc5f326713578e469c9f5be647978ebe24
> 
> I'll update this patch and re-post on this list at some point. There
> are some changes to the DMA ops that Russell is pushing. Once those
> stabilise, I'll update my patch.

In the meantime, I updated the patch on my devel branch:

http://linux-arm.org/git?p=linux-2.6.git;a=commitdiff;h=6dd5056b9abe1e38fae3eb8d576e562f49452b0f

Thanks for spotting this.

-- 
Catalin
