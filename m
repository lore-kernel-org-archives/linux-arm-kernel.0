From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 14:34:49 +0800
Subject: [PATCH V2 01/11] dma: imx-sdma: make channel0 operations atomic
In-Reply-To: <1336622038.1540.285.camel@vkoul-udesk3>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-2-git-send-email-richard.zhao@freescale.com>
 <1336622038.1540.285.camel@vkoul-udesk3>
Message-ID: <20120510063446.GA17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 09:23:58AM +0530, Vinod Koul wrote:
> On Wed, 2012-05-09 at 19:33 +0800, Richard Zhao wrote:
> > device_prep_dma_cyclic may be call in audio trigger function which is
> > atomic context, so we make it atomic too.
> > 
> >  - change channel0 lock to spinlock.
> >  - Use polling to wait for channel0 finish running.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Acked By: Vinod Koul <vinod.koul@linux.intel.com>
> 
Applied on imx/dt branch with Vinod's ack.  Thanks.

-- 
Regards,
Shawn
