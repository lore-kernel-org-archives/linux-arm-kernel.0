From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Sep 2014 15:43:45 +0100
Subject: [PATCH] of: amba: use of_dma_configure for AMBA devices
In-Reply-To: <90bd1ff3c93b827c12e1b3dc9ad3f227632d0f6e.1410954967.git.robin.murphy@arm.com>
References: <90bd1ff3c93b827c12e1b3dc9ad3f227632d0f6e.1410954967.git.robin.murphy@arm.com>
Message-ID: <20140917144345.GE10392@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 12:56:07PM +0100, Robin Murphy wrote:
> Commit 591c1e ("of: configure the platform device dma parameters)
> introduced a common mechanism to configure DMA from DT properties.
> AMBA devices created from DT can take advantage of this, too.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

It looks fine to me (and we could get rid of the AMBA bus hook on arm64
as well).

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
