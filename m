From: hch@lst.de (Christoph Hellwig)
Date: Tue, 27 Jun 2017 17:27:53 +0200
Subject: [PATCH v6 0/7] ARM: Fix dma_alloc_coherent() and friends for NOMMU
In-Reply-To: <1498468741-12020-1-git-send-email-vladimir.murzin@arm.com>
References: <1498468741-12020-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20170627152753.GA29186@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've applied patches 1, 3 and 4 to the dma-mapping tree.  2 will need
a respin for less code duplication.  I'd be happy to take 5,6 and 7 if
Russell is fine with that.
