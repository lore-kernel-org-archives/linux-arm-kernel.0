From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sat, 25 Aug 2012 15:33:27 +0300
Subject: [PATCH RESEND] mtd: lpc32xx_mlc: Make driver independent of
 AMBA DMA engine driver
In-Reply-To: <1345674311-16874-1-git-send-email-stigge@antcom.de>
References: <1345674311-16874-1-git-send-email-stigge@antcom.de>
Message-ID: <1345898007.1815.7.camel@kyv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-08-23 at 00:25 +0200, Roland Stigge wrote:
> This patch makes the MLC NAND driver independent of the single AMBA DMA engine
> driver by using the platform data provided dma_filter callback.
> 
> (This also fixes the build error of the MLC NAND driver in case of module
> linking because the (not exported) reference to pl08x_filter_id is gone now.)
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

I already have both patches in l2-mtd.git. Please, use it as the
baseline for sending patches.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120825/c350c170/attachment.sig>
