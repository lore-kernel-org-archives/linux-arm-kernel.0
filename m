From: vinod.koul@intel.com (Vinod Koul)
Date: Sat, 07 Jan 2012 13:44:00 +0530
Subject: [PATCH 1/2] dmaengine: Fix status handling in imx-dma.
In-Reply-To: <20120106124311.GJ5446@pengutronix.de>
References: <1325506706-10028-1-git-send-email-javier.martin@vista-silicon.com>
 <1325829389.1540.95.camel@vkoul-udesk3>
 <20120106093752.GH5446@pengutronix.de>
 <1325848224.1540.102.camel@vkoul-udesk3>
 <20120106124311.GJ5446@pengutronix.de>
Message-ID: <1325924040.1540.104.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-01-06 at 13:43 +0100, Sascha Hauer wrote:
> On Fri, Jan 06, 2012 at 04:40:24PM +0530, Vinod Koul wrote:
> The transfer is not started in prepare but in imxdmac->desc.tx_submit
> 
Well that's incorrect as well. It should be done in issue_pending

Care to fix this up?

-- 
~Vinod
