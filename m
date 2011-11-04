From: vinod.koul@intel.com (Koul, Vinod)
Date: Fri, 4 Nov 2011 18:36:56 +0530
Subject: arm-soc samsung patches blocked on dmaengine patches
In-Reply-To: <201111041400.44486.arnd@arndb.de>
References: <201111041400.44486.arnd@arndb.de>
Message-ID: <438BB0150E931F4B9CE701519A446301087AA53D66@bgsmsx502.gar.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Vinod and Kukjin,
> 
> Right now, all the patches from the arm-soc tree are merged into 3.2, but the
> samsung/cleanup and samsung/devel series are missing because they depend on
> patches in the dmaengine tree. I'm not sure about the status of that tree,
> but I didn't see a pull request for them yet.
> 
> Should I just submit the samsung tree with the dmaengine patches included,
> or keep waiting?
> 
Arnd,

I have already sent pull request to Linus on Monday[1], still waiting for
these to get merged

--
~Vinod

[1]: http://comments.gmane.org/gmane.linux.kernel/1209052
