From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 30 Jan 2017 18:47:21 +0100
Subject: [PATCH RESEND 2/5] dmaengine: Provide a wrapper for memcpy
 operations
In-Reply-To: <20170130165417.GF19244@localhost>
References: <1485535324-28393-1-git-send-email-boris.brezillon@free-electrons.com>
 <1485535324-28393-3-git-send-email-boris.brezillon@free-electrons.com>
 <20170130165417.GF19244@localhost>
Message-ID: <20170130184721.072c0de1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Mon, 30 Jan 2017 22:24:17 +0530
Vinod Koul <vinod.koul@intel.com> wrote:

> On Fri, Jan 27, 2017 at 05:42:01PM +0100, Boris Brezillon wrote:
> > Almost all ->device_prep_dma_xx() methods have a wrapper defined in
> > dmaengine.h. Add one for  ->device_prep_dma_memcpy().  
> 
> Looks good to me.
> 
> Acked-by: Vinod Koul <vinod.koul@intel.com>
> 
> 

Maybe you can take this patch directly (the NAND related bits are for
4.12).
