From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 22 Feb 2016 08:21:37 +0530
Subject: [PATCH] dmaengine: edma: Fetch echan->edesc while holding lock
 in edma_comletion_handler
In-Reply-To: <1455196668-9327-1-git-send-email-peter.ujfalusi@ti.com>
References: <1455196668-9327-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20160222025136.GS19598@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 03:17:48PM +0200, Peter Ujfalusi wrote:
> In order to avoid possible race condition when client drivers are using
> dmaengine_terminate_sync() call to disable the channel.

Applied, thanks

-- 
~Vinod
