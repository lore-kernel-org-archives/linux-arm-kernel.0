From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Jan 2015 15:14:56 -0800
Subject: [PATCH] of/platform: teardown DMA mappings on device destruction
In-Reply-To: <1421427896-16928-1-git-send-email-will.deacon@arm.com>
References: <1421427896-16928-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150121231456.GH24851@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 05:04:56PM +0000, Will Deacon wrote:
> Now that we can create and attach to IOMMU domains via of_dma_configure,
> make sure we give the architecture a chance to tear them down when a
> platform or amba device is destroyed.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Arnd, could you queue this along with the other of_dma_* bits that you
> have please?

I'm not sure what those pieces are, but I've queued this in next/drivers.


-Olof
