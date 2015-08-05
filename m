From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 5 Aug 2015 10:56:12 +0530
Subject: [PATCH v2 1/2] dmaengine: Add an enum for the dmaengine
 alignment constraints
In-Reply-To: <1437381693-18948-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1437381693-18948-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150805052612.GN11789@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 10:41:32AM +0200, Maxime Ripard wrote:
> Most drivers need to set constraints on the buffer alignment for async tx
> operations. However, even though it is documented, some drivers either use
> a defined constant that is not matching what the alignment variable expects
> (like DMA_BUSWIDTH_* constants) or fill the alignment in bytes instead of
> power of two.
> 
> Add a new enum for these alignments that matches what the framework
> expects, and convert the drivers to it.

Applied, thanks

-- 
~Vinod
