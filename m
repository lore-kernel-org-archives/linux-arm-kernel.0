From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 8 May 2015 07:15:38 +0200
Subject: [PATCH v2 0/4] mtd: mxc_nand: fix 8 bit ECC and large oob
In-Reply-To: <cover.1430636819.git.baruch@tkos.co.il>
References: <cover.1430636819.git.baruch@tkos.co.il>
Message-ID: <20150508051538.GW6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 03, 2015 at 10:18:50AM +0300, Baruch Siach wrote:
> This patch series fixes mxc_nand bugs that I encountered while trying to use 8
> bit ECC mode on i.MX25 with the Micron MT29F8G08ABABA flash chip.
> 
> Many thanks to Uwe Kleine-K?nig for guiding me through the process of
> debugging and fixing, and for contributing a clean-up patch to this series.
> 
> This series applies and tested on v4.1-rc1.
> 
> This is version 2 of the patch series, addressing the comments and suggestion
> of Uwe Kleine-K?nig on the first series
> (http://thread.gmane.org/gmane.linux.ports.arm.kernel/408635). See each patch
> for detailed per-patch changelog.
> 
> Baruch Siach (3):
>   mtd: mxc_nand: limit the size of used oob
>   mtd: mxc_nand: fix truncate of unaligned oob copying
>   mtd: mxc_nand: generate nand_ecclayout for 8 bit ECC
> 
> Uwe Kleine-K?nig (1):
>   mtd: nand: mxc_nand: cleanup copy_spare function

I looked at this version and have only found some minor coding style
violations (spaces missing on both sides of operators).

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
