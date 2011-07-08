From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 8 Jul 2011 21:07:22 +0200
Subject: [PATCH v6 1/4] ARM: mxs: add GPMI-NAND support for imx23/imx28
In-Reply-To: <1310102885-4102-2-git-send-email-b32955@freescale.com>
References: <1310102885-4102-1-git-send-email-b32955@freescale.com>
	<1310102885-4102-2-git-send-email-b32955@freescale.com>
Message-ID: <20110708190722.GA16490@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Huang,

> diff --git a/arch/arm/mach-mxs/include/mach/gpmi-nand.h b/arch/arm/mach-mxs/include/mach/gpmi-nand.h
> new file mode 100644
> index 0000000..f1cf565
> --- /dev/null
> +++ b/arch/arm/mach-mxs/include/mach/gpmi-nand.h

I am also mostly happy with it now :)

Assuming the above file will be needed by mx50/mx6, too, would it make sense to
put it to include/linux/mtd/gpmi-nand.h right from the beginning?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110708/847a40ea/attachment-0001.sig>
