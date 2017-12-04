From: hch@lst.de (Christoph Hellwig)
Date: Mon,  4 Dec 2017 08:35:58 -0800
Subject: replace PCI_DMA_BUS_IS_PHYS with a per-instance flag
Message-ID: <20171204163601.3055-1-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this small series tries to get rid of the global and misnamed
PCI_DMA_BUS_IS_PHYS flag, and replace it with a setting in each
struct dma_map_ops instance.
