From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 2 Sep 2016 16:37:29 +0530
Subject: [PATCH V3] dmaengine: dmatest: exclude compare and fill time
 during perf report
In-Reply-To: <1472738575-7771-1-git-send-email-okaya@codeaurora.org>
References: <1472738575-7771-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20160902110729.GF9355@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2016 at 10:02:55AM -0400, Sinan Kaya wrote:
> Dmatest is currently including compare and fill time into the
> calculated performance numbers. This does not reflect the HW
> capability and the results vary based on the CPU speed instead of
> the HW speed.

Applied, thanks

-- 
~Vinod
