From: hch@lst.de (Christoph Hellwig)
Date: Wed, 25 Apr 2018 07:15:26 +0200
Subject: centralize SWIOTLB config symbol and misc other cleanups V3
Message-ID: <20180425051539.1989-1-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this seris aims for a single defintion of the Kconfig symbol.  To get
there various cleanups, mostly about config symbols are included as well.

Changes since V2:
 - swiotlb doesn't need the dma_length field by itself, so don't select it
 - don't offer a user visible SWIOTLB choice

Chages since V1:
 - fixed a incorrect Reviewed-by that should be a Signed-off-by.
