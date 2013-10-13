From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Oct 2013 00:48:12 +0100
Subject: [PATCH 1/1] dma: imx-sdma: setup dma mask
In-Reply-To: <20131013161801.GP2954@intel.com>
References: <1380623464-24652-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380623464-24652-2-git-send-email-philippe.retornaz@epfl.ch>
 <20131013161801.GP2954@intel.com>
Message-ID: <20131013234812.GI25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 13, 2013 at 09:48:01PM +0530, Vinod Koul wrote:
> On Tue, Oct 01, 2013 at 12:31:04PM +0200, Philippe R?tornaz wrote:
> > The dma mask is not configured in the current code.
> > This was triggered by soc-dmaengine-pcm which allocate the dma
> > buffers with the imx-sdma as device.
> > This commit fix audio on imx31.
> > 
> > Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
> This needs to go thru Russell's tree, that has the below API
> 
> Acked-by Vinod Koul <vinod.koul@intel.com>

Indeed.
