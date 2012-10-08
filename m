From: marex@denx.de (Marek Vasut)
Date: Mon, 8 Oct 2012 15:15:32 +0200
Subject: [PATCH V4] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <20121008092530.GA22051@pengutronix.de>
References: <1345779871-7677-1-git-send-email-marex@denx.de>
 <20121008092530.GA22051@pengutronix.de>
Message-ID: <201210081515.32863.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> On Fri, Aug 24, 2012 at 05:44:31AM +0200, Marek Vasut wrote:
> > This patch implements DMA support into mxs-i2c. DMA transfers are now
> > enabled via DT. The DMA operation is enabled by default.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> 
> Thanks, applied to -next.
> 
> I am meanwhile thinking the driver needs massive changes

+1 it does.

> probably dropping PIOQUEUE entirely

Yes, in favor of PIO which can do switching with DMA.

> This is probably best done via incremental
> patches to this one. I have sketches which were sadly not ready for this
> merge-window :(

Cc me when submitting, I'd like to see those.

Best regards,
Marek Vasut
