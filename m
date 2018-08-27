From: hch@lst.de (Christoph Hellwig)
Date: Mon, 27 Aug 2018 10:47:07 +0200
Subject: cleanup ->dma_configure calling conventions
Message-ID: <20180827084711.23407-1-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this series cleans up a bit how we call ->dma_configure and how
we clean up after tearing down a device that the method did set
up.
