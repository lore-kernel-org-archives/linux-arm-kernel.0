From: hch@lst.de (Christoph Hellwig)
Date: Mon, 17 Sep 2018 17:38:17 +0200
Subject: move swiotlb noncoherent dma support from arm64 to generic code
Message-ID: <20180917153826.28052-1-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this series starts with various swiotlb cleanups, then adds support for
non-cache coherent devices to the generic swiotlb support, and finally
switches arm64 to use the generic code.

Given that this series depends on patches in the dma-mapping tree, or
pending for it I've also published a git tree here:

    git://git.infradead.org/users/hch/misc.git swiotlb-noncoherent

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb-noncoherent
