From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 07 Dec 2009 12:13:31 +0000
Subject: dma_cache_maint_contiguous should be patched as dma_cache_maint do
In-Reply-To: <SNT109-W5018A3A559755D12BA4C73A7900@phx.gbl>
References: <SNT109-W5018A3A559755D12BA4C73A7900@phx.gbl>
Message-ID: <1260188011.18974.38.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-12-07 at 03:13 +0000, mkl lin wrote:
> I'm new to this ML and kernel hacking, so please correct me if I'm
> wrong.
> 
> I had had an issue on USB data read, which is often incorrect. With
> the help of this ML and some luck, I think the following patch that
> patch dma_cache_maint should be applied to dma_cache_maint_contiguous,
> which is called by dma_cache_maint_page.
> 
> Broadcast the DMA cache operations on ARMv6 SMP hardware
> http://linux-arm.org/git?p=linux-2.6.git;a=commitdiff;h=f1c242dc5f326713578e469c9f5be647978ebe24

I'll update this patch and re-post on this list at some point. There are
some changes to the DMA ops that Russell is pushing. Once those
stabilise, I'll update my patch.

-- 
Catalin
