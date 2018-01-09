From: jesper.nilsson@axis.com (Jesper Nilsson)
Date: Tue, 9 Jan 2018 16:53:17 +0100
Subject: [PATCH 34/67] cris: use dma-direct
In-Reply-To: <20171229081911.2802-35-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-35-hch@lst.de>
Message-ID: <20180109155317.GN32368@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 29, 2017 at 09:18:38AM +0100, Christoph Hellwig wrote:
> cris currently has an incomplete direct mapping dma_map_ops implementation
> is PCI support is enabled.  Replace it with the fully feature generic
> dma-direct implementation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For CRIS:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  arch/cris/Kconfig                       |  4 ++
>  arch/cris/arch-v32/drivers/pci/Makefile |  2 +-
>  arch/cris/arch-v32/drivers/pci/dma.c    | 78 ---------------------------------
>  arch/cris/include/asm/Kbuild            |  1 +
>  arch/cris/include/asm/dma-mapping.h     | 20 ---------
>  5 files changed, 6 insertions(+), 99 deletions(-)
>  delete mode 100644 arch/cris/arch-v32/drivers/pci/dma.c
>  delete mode 100644 arch/cris/include/asm/dma-mapping.h
> 

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson at axis.com
