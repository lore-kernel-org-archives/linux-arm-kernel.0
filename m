From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 30 Jan 2017 22:24:17 +0530
Subject: [PATCH RESEND 2/5] dmaengine: Provide a wrapper for memcpy
 operations
In-Reply-To: <1485535324-28393-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1485535324-28393-1-git-send-email-boris.brezillon@free-electrons.com>
 <1485535324-28393-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170130165417.GF19244@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 05:42:01PM +0100, Boris Brezillon wrote:
> Almost all ->device_prep_dma_xx() methods have a wrapper defined in
> dmaengine.h. Add one for  ->device_prep_dma_memcpy().

Looks good to me.

Acked-by: Vinod Koul <vinod.koul@intel.com>


-- 
~Vinod
