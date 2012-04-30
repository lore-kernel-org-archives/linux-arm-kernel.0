From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 30 Apr 2012 22:30:16 +0200
Subject: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
In-Reply-To: <201204302207.39112.marex@denx.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <201204301410.14393.marex@denx.de>
 <20120430195221.GB28226@pengutronix.de>
 <201204302207.39112.marex@denx.de>
Message-ID: <20120430203016.GD28226@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > What has the compiler version to do with the relevance? :) This has
> > nothing to do with adding DMA support. Plus, nobody so far could tell me
> > what path gcc is seeing there.
> 
> It complains that data might be undefined, do you want it in a separate patch 
> then ?

Yes, but only if you can prove that the compiler is right.

> I still havent figured out how to flip between pioqueue mode and dma mode 
> without the controller getting confused, so I prefer to postpone it into 
> subsequent patch. Eventually, I agree it'd be cool to be able to do this 
> switching.

Yes, send V2 with DMA by default, and I will give a try on the
mode-switching later, too.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120430/49e0a24c/attachment.sig>
