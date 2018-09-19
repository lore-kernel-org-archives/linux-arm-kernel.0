From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Sep 2018 16:37:00 +0200
Subject: [PATCH v5 10/12] ARM64: declare __phys_to_dma on
 ARCH_HAS_PHYS_TO_DMA
In-Reply-To: <1537367527-20773-11-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-11-git-send-email-jim2101024@gmail.com>
Message-ID: <20180919143700.GA29096@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is useless on its own.  Please merge it into whatever patch
selects ARCH_HAS_PHYS_TO_DMA and actually implements the functions.
