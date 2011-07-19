From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 19 Jul 2011 10:21:46 +0200
Subject: [PATCH 1/1] ARM: mxs-dma: reset after disable channel
In-Reply-To: <20110719040215.GF3838@S2100-06.ap.freescale.net>
References: <1311048596-19932-1-git-send-email-b29396@freescale.com>
	<20110719040215.GF3838@S2100-06.ap.freescale.net>
Message-ID: <20110719082146.GA1951@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 12:02:16PM +0800, Shawn Guo wrote:
> On Tue, Jul 19, 2011 at 12:09:56PM +0800, Dong Aisheng wrote:
> > We met some channels in abnormal state after disable.
> > Reset it to get a clean state.
> > 
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > ---
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Just to make sure: Did you investigate where the "abnormal" state came
from and if that could be fixed?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110719/f22834db/attachment.sig>
