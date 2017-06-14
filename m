From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 14 Jun 2017 14:01:27 +0530
Subject: [PATCH 03/44] dmaengine: ioat: don't use DMA_ERROR_CODE
In-Reply-To: <20170608132609.32662-4-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-4-hch@lst.de>
Message-ID: <20170614083127.GJ13020@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 03:25:28PM +0200, Christoph Hellwig wrote:
> DMA_ERROR_CODE is not a public API and will go away.  Instead properly
> unwind based on the loop counter.

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
