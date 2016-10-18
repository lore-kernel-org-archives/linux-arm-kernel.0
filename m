From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 18 Oct 2016 20:33:53 +0530
Subject: [PATCH] dmaengine: qcom_hidma: prevent disable in error
In-Reply-To: <1475782394-27887-1-git-send-email-okaya@codeaurora.org>
References: <1475782394-27887-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20161018150353.GC2467@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2016 at 03:33:14PM -0400, Sinan Kaya wrote:
> When an error is observed, we try to disable the channel and prevent
> further accesses from the client.
> 
> Depending on the type of error, transitioning into disabled state might
> not be possible. Adding a check to make sure that HW is in enabled/running
> state before the disable transition happens.

Applied, thanks

-- 
~Vinod
