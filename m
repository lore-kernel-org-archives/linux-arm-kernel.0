From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Mon, 29 Aug 2011 20:11:15 +0530
Subject: i.MX SDMA patches
In-Reply-To: <1314263017-18099-1-git-send-email-s.hauer@pengutronix.de>
References: <1314263017-18099-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1314628875.1606.152.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-08-25 at 11:03 +0200, Sascha Hauer wrote:
> The following series has some i.MX SDMA fixes. The first two
> should go into -rc, the third either in -rc or next. It fixes
> that the driver blocks in probe() when the driver is compiled
> into the kernel but the firmware is not. From this point of
> view it should go in -rc, but on the other hand it's no straight
> forward fix.
> 
> Sascha
> 
> Sascha Hauer (3):
>       dmaengine i.MX SDMA: lock channel 0
>       dmaengine i.MX SDMA: set firmware scripts addresses to negative value initially
>       dmaengine i.MX SDMA: use request_firmware_nowait
> 
>  drivers/dma/imx-sdma.c |   47 ++++++++++++++++++++++++++++++++++++++---------
>  1 files changed, 38 insertions(+), 9 deletions(-)
Applied, Thanks

-- 
~Vinod
