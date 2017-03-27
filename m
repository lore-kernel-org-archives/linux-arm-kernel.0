From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 27 Mar 2017 10:44:19 +0530
Subject: [PATCH 1/2] dmaengine: qcom_hidma: disable/enable IRQs on
 pause/resume
In-Reply-To: <1490483043-4364-1-git-send-email-okaya@codeaurora.org>
References: <1490483043-4364-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20170327051418.GE9308@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 25, 2017 at 07:04:02PM -0400, Sinan Kaya wrote:
> Once the channels are stopped, disable interrupts to make sure no new
> HW interaction can happen.
> 
> Similarly, re-enable the interrupts only if we know that channel is
> operational again.

Applied both, thanks

-- 
~Vinod
