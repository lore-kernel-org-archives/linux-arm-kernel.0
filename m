From: joelf@ti.com (Joel Fernandes)
Date: Wed, 16 Oct 2013 19:31:20 -0500
Subject: [PATCH 09/28] dmaengine: edma: use DMA_COMPLETE for dma completion
 status
In-Reply-To: <1381940926-25564-10-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
 <1381940926-25564-10-git-send-email-vinod.koul@intel.com>
Message-ID: <525F2FD8.9090008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2013 11:28 AM, Vinod Koul wrote:
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> CC: Joel Fernandes <joelf@ti.com>

The audio davinci-pcm driver once converted to dmaengine usage would be the
first user of tx_status so I will get to testing this patch better then.

Anyway, with this patch applied I compile-tested and boot-tested it and it
doesn't appear to break anything.

Tested-by: Joel Fernandes <joelf@ti.com>

thanks,

-Joel
