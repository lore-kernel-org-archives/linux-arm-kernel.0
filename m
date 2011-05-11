From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 May 2011 18:22:09 +0100
Subject: [PATCH 1/2] ARM: Replace platform definition of
	ISA_DMA_THRESHOLD/MAX_DMA_ADDRESS
In-Reply-To: <E1QKCDr-0007Nk-4P@rmk-PC.arm.linux.org.uk>
References: <20110511162450.GF5315@n2100.arm.linux.org.uk>
	<E1QKCDr-0007Nk-4P@rmk-PC.arm.linux.org.uk>
Message-ID: <1305134529.10103.124.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-11 at 17:25 +0100, Russell King - ARM Linux wrote:
> The values of ISA_DMA_THRESHOLD and MAX_DMA_ADDRESS are related; one is
> the physical/bus address, the other is the virtual address.  Both need
> to be kept in step, so rather than having platforms define both, allow
> them to define a single macro which sets both of these macros
> appropraitely.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
