From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 12 Oct 2017 19:35:05 +0530
Subject: [PATCH][dma-next] dmaengine: stm32: remove redundant
 initialization of hwdesc
In-Reply-To: <20171011102822.19166-1-colin.king@canonical.com>
References: <20171011102822.19166-1-colin.king@canonical.com>
Message-ID: <20171012140505.GP30097@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 11:28:22AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> hwdesc is being initialized to desc->hwdesc but this is never read
> as hwdesc is overwritten in a for-loop.  Remove the redundant
> initialization and move the declaration of hwdesc into the for-loop.
> 
> Cleans up clang warning:
> Value stored to 'hwdesc' during its initialization is never read

Applied, thanks

-- 
~Vinod
