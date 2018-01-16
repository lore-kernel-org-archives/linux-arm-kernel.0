From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 15 Jan 2018 23:53:38 -0800
Subject: consolidate swiotlb dma_map implementations
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
Message-ID: <20180116075338.GB12693@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've pulled this into the dma-mapping for-next tree, including the
missing free_pages noted.  I'd be fine to rebase another day or two
for additional reviews or important fixes.
