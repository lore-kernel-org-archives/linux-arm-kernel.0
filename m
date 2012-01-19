From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 19 Jan 2012 10:45:13 +0100
Subject: [PATCH 00/10] patch set about the MXS-DMA
In-Reply-To: <20120119091034.GH2247@S2101-09.ap.freescale.net>
References: <1326953767-24155-1-git-send-email-b32955@freescale.com>
 <20120119091034.GH2247@S2101-09.ap.freescale.net>
Message-ID: <20120119094513.GB2630@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > [2] patch 6 ~ patch 10: rewrite the last parameter of mxs_dma_prep_slave_sg().
> 
> For the sake of bitsec, at least patches #7 and #8 need to be one patch.
> That said, if I apply the series and then check out the commit at patch
> #7, you need to all mxs-dma client drivers, mxs-mmc, gpmi do not break.

I'd say patch 6-10 should be squashed, simply. My personal preference is
to change #9 to simply read the register when needed and do not expand
the struct, but this is a minor thing.

Regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120119/89b7a925/attachment.sig>
