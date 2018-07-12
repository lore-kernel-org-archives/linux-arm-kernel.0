From: hch@lst.de (Christoph Hellwig)
Date: Thu, 12 Jul 2018 09:20:51 +0200
Subject: [RFC PATCH 1/4] dma-mapping: Generalise dma_32bit_limit flag
In-Reply-To: <868cead9-88a7-e58d-3452-a78e19be5f47@arm.com>
References: <cover.1531239284.git.robin.murphy@arm.com>
 <a85a5fe22fced65b2960251fc6e8d8f1e68f828a.1531239284.git.robin.murphy@arm.com>
 <20180710180433.GB26285@lst.de>
 <868cead9-88a7-e58d-3452-a78e19be5f47@arm.com>
Message-ID: <20180712072051.GC15624@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 05:56:40PM +0100, Robin Murphy wrote:
> Indeed, once we've found an approach that everyone's happy with we can have 
> a more thorough audit of exactly where else it needs to be applied. FWIW 
> I'm not aware of any 32-bit Arm systems affected by this*, but if they do 
> exist then at least there's no risk of regression since they've always been 
> busted.

Ok, great.  I just assumed arm might be affected due to the fact that
it currently parses dma-ranges DT properties.
