From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 30 Sep 2016 23:19:11 +0530
Subject: [PATCH][V2] dmaengine: coh901318: fix integer overflow when
 shifting more than 32 places
In-Reply-To: <20160929181438.14374-1-colin.king@canonical.com>
References: <20160929181438.14374-1-colin.king@canonical.com>
Message-ID: <20160930174911.GW2467@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2016 at 07:14:38PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently U300_DMA_CHANNELS is set to 40, meaning that the shift of 1 can
> be more than 32 places, which leads to a 32 bit integer overflow. Fix this
> by using 1ULL instead of 1 before shifting it.  Also add braces on the
> for-loop to keep with coding style conventions.

Applied, thanks

-- 
~Vinod
