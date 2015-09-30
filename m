From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 30 Sep 2015 13:35:24 +0530
Subject: [PATCH] dmaengine: xgene-dma: Fix overwritting DMA tx ring
In-Reply-To: <1442390603-21129-1-git-send-email-rsahu@apm.com>
References: <1442390603-21129-1-git-send-email-rsahu@apm.com>
Message-ID: <20150930080524.GG21690@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 01:33:23PM +0530, Rameshwar Prasad Sahu wrote:
> This patch fixes an over flow issue with the TX ring descriptor. Each
> descriptor is 32B in size and an operation requires 2 of these
> descriptors.

Applied, thanks

-- 
~Vinod
