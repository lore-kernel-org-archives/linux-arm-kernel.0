From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 24 Jun 2011 11:18:07 +0200
Subject: [PATCH/RFC 0/8] ARM: DMA-mapping framework redesign
In-Reply-To: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20110624091807.GC29299@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Mon, Jun 20, 2011 at 09:50:05AM +0200, Marek Szyprowski wrote:
> This patch series is a continuation of my works on implementing generic
> IOMMU support in DMA mapping framework for ARM architecture. Now I
> focused on the DMA mapping framework itself. It turned out that adding
> support for common dma_map_ops structure was not that hard as I initally
> thought. After some modification most of the code fits really well to
> the generic dma_map_ops methods.

I appreciate your progress on this generic dma_ops implementation. But
for now it looks very ARM specific. Do you have plans to extend it to
non-ARM iommu-api implementations too?

	Joerg
