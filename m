From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 18 Dec 2015 11:03:41 +0530
Subject: [PATCH] dmaengine: edma: Add probe callback to edma_tptc_driver
In-Reply-To: <1450271945-15263-1-git-send-email-peter.ujfalusi@ti.com>
References: <1450271945-15263-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20151218053341.GT1854@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 03:19:05PM +0200, Peter Ujfalusi wrote:
> Due to changes in device and platform code drivers w/o probe will fail to
> load. This means that the devices for eDMA TPTCs are goign to be without
> driver and omap hwmod code will turn them off after the kernel finished
> loading:
> [    3.015900] platform 49800000.tptc: omap_device_late_idle: enabled but no driver.  Idling
> [    3.024671] platform 49a00000.tptc: omap_device_late_idle: enabled but no driver.  Idling
> 
> This will prevent eDMA to work since the TPTCs are not enabled.

Applied, thanks

-- 
~Vinod
