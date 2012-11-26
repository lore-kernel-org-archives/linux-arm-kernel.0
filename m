From: shuah.khan@hp.com (Shuah Khan)
Date: Mon, 26 Nov 2012 09:09:50 -0700
Subject: [PATCH 0/9] dma_debug: add debug_dma_mapping_error support to
 architectures that support DMA_DEBUG_API
In-Reply-To: <20121126112217.GG25742@8bytes.org>
References: <1353706142.5270.93.camel@lorien2>
 <20121126112217.GG25742@8bytes.org>
Message-ID: <1353946190.2917.5.camel@lorien2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-11-26 at 12:22 +0100, Joerg Roedel wrote:
> Hi Shuah,
> 
> On Fri, Nov 23, 2012 at 02:29:02PM -0700, Shuah Khan wrote:
> > x86 - done in the first patch that added the feature.
> > 
> > ARM64: dma_debug: add debug_dma_mapping_error support
> > c6x: dma_debug: add debug_dma_mapping_error support
> > ia64: dma_debug: add debug_dma_mapping_error support
> > microblaze: dma-mapping: support debug_dma_mapping_error
> > mips: dma_debug: add debug_dma_mapping_error support
> > powerpc: dma_debug: add debug_dma_mapping_error support
> > sh: dma_debug: add debug_dma_mapping_error support
> > sparc: dma_debug: add debug_dma_mapping_error support
> > tile: dma_debug: add debug_dma_mapping_error support
> 
> Have you compile-tested the invididual archs you are changing here?
> 

Joerg,

Yes I compile tested all of them (except microblaze) on Nov 20th
linux_next git. The patch for microblaze is already in linux_next when I
tried to apply the patch to Nov 20th linux-next and figured that is
already covered and skipped that one.

-- Shuah
