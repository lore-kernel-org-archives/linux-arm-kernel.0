From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 20 Aug 2010 08:31:11 +0200
Subject: [PATCH] lpc32xx/clock: Use && instead of &
In-Reply-To: <083DF309106F364B939360100EC290F80ACF95B12A@eu1rdcrdc1wx030.exi.nxp.com>
References: <1281451732-19294-1-git-send-email-w.sang@pengutronix.de>
	<083DF309106F364B939360100EC290F80ACF95B12A@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20100820063111.GA7313@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 20, 2010 at 12:50:17AM +0200, Kevin Wells wrote:
> > Subject: [PATCH] lpc32xx/clock: Use && instead of &
> > 
> > Because we are connecting two expressions here, not binary values.
> > 
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Kevin Wells <wellsk40@gmail.com>
> 
> Acked-by: Kevin Wells <wellsk40@gmail.com>
> 
> Do you want me to pull this patch into my next series?

Yes, I think this would be easiest.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100820/f5192be9/attachment-0001.sig>
