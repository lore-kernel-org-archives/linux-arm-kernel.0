From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Sep 2012 15:23:26 +0800
Subject: [PATCH v2 04/15] dmaengine: Pass no_wakeup parameter via
 device_prep_dma_cyclic() callback
In-Reply-To: <5056CE65.9080401@ti.com>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-5-git-send-email-peter.ujfalusi@ti.com>
 <20120917063451.GB6413@S2101-09.ap.freescale.net>
 <5056CE65.9080401@ti.com>
Message-ID: <20120917072323.GD1338@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 10:16:53AM +0300, Peter Ujfalusi wrote:
> All users of this callback is updated with this patch.
> The public API (dmaengine_prep_dma_cyclic) is only used by ASoC, which has
> been updated by the previous patch.
> 
Ah, ok.  You actually changed dmaengine_prep_dma_cyclic signature before
this patch.  Sorry, I overlooked that.

-- 
Regards,
Shawn
