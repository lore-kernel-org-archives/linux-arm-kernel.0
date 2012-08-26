From: stigge@antcom.de (Roland Stigge)
Date: Sun, 26 Aug 2012 16:27:06 +0200
Subject: [PATCH RESEND] mtd: lpc32xx_mlc: Make driver independent of AMBA
 DMA engine driver
In-Reply-To: <1345898007.1815.7.camel@kyv>
References: <1345674311-16874-1-git-send-email-stigge@antcom.de>
 <1345898007.1815.7.camel@kyv>
Message-ID: <503A323A.9090309@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 25/08/12 14:33, Artem Bityutskiy wrote:
> On Thu, 2012-08-23 at 00:25 +0200, Roland Stigge wrote:
>> This patch makes the MLC NAND driver independent of the single
>> AMBA DMA engine driver by using the platform data provided
>> dma_filter callback.
>> 
>> (This also fixes the build error of the MLC NAND driver in case
>> of module linking because the (not exported) reference to
>> pl08x_filter_id is gone now.)
>> 
>> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> I already have both patches in l2-mtd.git. Please, use it as the 
> baseline for sending patches.

Yes, noticed to late that you have already applied it, sorry.

The recently posted cleanup patches for LPC32xx SLC and MLC drivers
apply to l2-mtd.git, anyway.

Thanks,

Roland
