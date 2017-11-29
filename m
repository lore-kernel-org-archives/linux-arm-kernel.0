From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 29 Nov 2017 19:49:30 +0530
Subject: [PATCH] dmaengine: at_hdmac: fix potential NULL pointer
 dereference in atc_prep_dma_interleaved
In-Reply-To: <20171120142814.GA3315@embeddedor.com>
References: <20171120142814.GA3315@embeddedor.com>
Message-ID: <20171129141930.GJ32417@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 08:28:14AM -0600, Gustavo A. R. Silva wrote:
> _xt_ is being dereferenced before it is null checked, hence there is a
> potential null pointer dereference.
> 
> Fix this by moving the pointer dereference after _xt_ has been null
> checked.
> 
> This issue was detected with the help of Coccinelle.

Applied, thanks

-- 
~Vinod
