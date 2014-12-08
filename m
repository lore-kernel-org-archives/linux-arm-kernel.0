From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 8 Dec 2014 18:44:12 +0530
Subject: [PATCH] dmaengine: fsl-edma: fix calculation of remaining bytes
In-Reply-To: <1415879762-12177-1-git-send-email-stefan@agner.ch>
References: <1415879762-12177-1-git-send-email-stefan@agner.ch>
Message-ID: <20141208131412.GL16827@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 12:56:02PM +0100, Stefan Agner wrote:
> If the current transfer control descriptor (TCD) was not yet started,
> the address will be the same as the initial address. Hence test if the
> current address is less than or equal to the start address of each TCD.
Applied, thanks

-- 
~Vinod
