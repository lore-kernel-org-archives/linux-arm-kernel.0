From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 30 Aug 2016 22:34:22 +0530
Subject: [PATCH V3 3/3] dmaengine: qcom_hidma: add error reporting for
 tx_status
In-Reply-To: <1471927691-28827-4-git-send-email-okaya@codeaurora.org>
References: <1471927691-28827-1-git-send-email-okaya@codeaurora.org>
 <1471927691-28827-4-git-send-email-okaya@codeaurora.org>
Message-ID: <20160830170422.GN9355@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 12:48:11AM -0400, Sinan Kaya wrote:

>  	spin_lock_init(&lldev->lock);
> -	tasklet_init(&lldev->rst_task, hidma_ll_abort, (unsigned long)lldev);

??

This is not described in changlog? If you are not using in anywhere else,
then rst_task variable should be removed too..

-- 
~Vinod
