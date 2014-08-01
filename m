From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Aug 2014 14:55:18 +0200
Subject: [PATCH v2] dma-mapping: Provide write-combine allocations
In-Reply-To: <1403863018-20033-1-git-send-email-thierry.reding@gmail.com>
References: <1403863018-20033-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <201408011455.18991.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 June 2014, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Provide an implementation for dma_{alloc,free,mmap}_writecombine() when
> the architecture supports DMA attributes.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>

I'd suggest this gets merged through Russell's tree. Please add to the
patch tracker with my Ack.

	Arnd
