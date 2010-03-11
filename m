From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Mar 2010 11:01:50 +0000
Subject: [PATCH] ARM: pgprot_dmacoherent() for non-mmu builds
In-Reply-To: <201003100546.o2A5kiXV009192@goober.internal.moreton.com.au>
References: <201003100546.o2A5kiXV009192@goober.internal.moreton.com.au>
Message-ID: <20100311110149.GB25011@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 10, 2010 at 03:46:44PM +1000, Greg Ungerer wrote:
> ARM: pgprot_dmacoherent() for non-mmu builds
> 
> Commit 26a26d329688ab018e068b412b03d43d7c299f0a ("dma-mapping: switch
> ARMv7 DMA mappings to retain 'memory' attribute") added a new macro,
> pgprot_dmacoherent(), to correctly map DMA memory. The non-mmu pgtable
> support code also needs to implement this macro, otherwise when
> compiling you get:

Ok.
