From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 21 Aug 2015 15:49:27 +0530
Subject: [PATCH v2] dmaengine: xgene-dma: Fix the lock to allow client
 for further submission of requests
In-Reply-To: <1440147814-22016-1-git-send-email-rsahu@apm.com>
References: <1440147814-22016-1-git-send-email-rsahu@apm.com>
Message-ID: <20150821101927.GQ13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 02:33:34PM +0530, Rameshwar Prasad Sahu wrote:
> This patch provides the fix in the cleanup routing such that client can perform
> further submission by releasing the lock before calling client's callback function.

Applied, thanks

-- 
~Vinod
