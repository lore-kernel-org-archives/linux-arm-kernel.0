From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 18 Dec 2015 11:19:09 +0530
Subject: [PATCH V03 0/5] dmaengine: New 'universal' API for requesting
 channel
In-Reply-To: <1450126062-8063-1-git-send-email-peter.ujfalusi@ti.com>
References: <1450126062-8063-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20151218054908.GV1854@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 10:47:37PM +0200, Peter Ujfalusi wrote:
> Hi,
> 
> As it has been discussed in the following thread:
> http://www.gossamer-threads.com/lists/linux/kernel/2181487#2181487
> 
> With this series I have taken a path which would result two new API, which can
> be used to convert most of the current users already and with some work all
> users might be able to move to this set.
> With this set the filter_fn used for legacy (non DT/ACPI) channel request is no
> longer needed to be exported to client drivers since the selection of the
> correct filter_fn will be done in the core.

Applied now,

Thanks for this rework, much appreciated :-)

-- 
~Vinod
