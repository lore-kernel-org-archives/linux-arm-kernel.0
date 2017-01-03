From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 3 Jan 2017 09:19:23 +0530
Subject: [PATCH] dmaengine: pl330: Fix runtime PM support for terminated
 transfers
In-Reply-To: <1481884751-21411-1-git-send-email-m.szyprowski@samsung.com>
References: <1481884751-21411-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170103034923.GD3573@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2016 at 11:39:11AM +0100, Marek Szyprowski wrote:
> PL330 DMA engine driver is leaking a runtime reference after any terminated
> DMA transactions. This patch fixes this issue by tracking runtime PM state
> of the device and making additional call to pm_runtime_put() in terminate_all
> callback if needed.

Applied now

-- 
~Vinod
