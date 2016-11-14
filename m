From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 14 Nov 2016 10:36:56 +0530
Subject: [PATCH v1] ARM:dmaengine:sun6i:fix the uninitialized value for
 v_lli
In-Reply-To: <20161102053112.GA8109@arx-xi>
References: <20161102053112.GA8109@arx-xi>
Message-ID: <20161114050656.GS3000@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2016 at 01:31:12PM +0800, Axl-zhang wrote:
> dma_pool_alloc does not initialize the value of the newly allocated
> block for the v_lli, and the uninitilize value make the tests failed
> which is on pine64 with dmatest.
> we can fix it just change the "|=" to "=" for the v_lli->cfg.

Applied after fixing the title. We dont need ARM.
Also spaces after each tag please..

-- 
~Vinod
