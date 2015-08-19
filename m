From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 19 Aug 2015 22:34:20 +0530
Subject: [PATCHv4 4/6] dmaengine: mv_xor: remove
 mv_xor_chan->current_type field
In-Reply-To: <1436365699-6862-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1436365699-6862-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1436365699-6862-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150819170420.GM13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 04:28:17PM +0200, Thomas Petazzoni wrote:
> Since commit 3e4f52e2da9f6 ("dma: mv_xor: Simplify the DMA_MEMCPY
> operation"), this field is no longer used, so get rid of it.

This one fails to apply, can you pls rebase

-- 
~Vinod
