From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 20 Jul 2015 17:26:37 +0200
Subject: [PATCH v4 0/4] arm64: IOMMU-backed DMA mapping
In-Reply-To: <cover.1437070995.git.robin.murphy@arm.com>
References: <cover.1437070995.git.robin.murphy@arm.com>
Message-ID: <20150720152637.GD10969@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 07:40:11PM +0100, Robin Murphy wrote:
>  arch/arm64/Kconfig                   |   1 +
>  arch/arm64/include/asm/dma-mapping.h |  15 +-
>  arch/arm64/mm/dma-mapping.c          | 452 +++++++++++++++++++++++++++++

What happened to the plan to merge this with the existing iommu-based
dma-api implementation for 32 bit ARM?


	Joerg
