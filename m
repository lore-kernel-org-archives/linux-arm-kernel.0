From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 11 Jul 2011 13:00:24 +0200
Subject: [PATCH v7 0/4] add the GPMI-NAND support for imx23/imx28
In-Reply-To: <1310371266-10704-1-git-send-email-b32955@freescale.com>
References: <1310371266-10704-1-git-send-email-b32955@freescale.com>
Message-ID: <20110711110024.GB11153@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 11, 2011 at 04:01:02PM +0800, Huang Shijie wrote:

> The general-purpose media interface(GPMI) controller is a flexible interface
> to up to several NAND flashs.
> 
> The Bose Ray-Choudhury Hocquenghem(BCH) module is a hardware ECC accelerator.
> 
> With the help of BCH, the GPMI controller can choose to do the hardware ECC or
> not.
> 
> v6 --> v7:
> 	[0] rename RES_SIZE to GPMI_NAND_RES_SIZE.
> 	[1] move gpmi-nand.h to `include/linux/mtd/` directory.
> 	[2] remove comment for new pad control.
> 	[3] others

Could you also post a driver which is adapted to all these changes?
The series looks good now; still I want to test it a little just to make
sure...

Thanks,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110711/2e3b0e8b/attachment.sig>
