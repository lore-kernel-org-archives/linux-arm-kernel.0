From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Jan 2010 11:24:40 +0100
Subject: [PATCH 0/3] mx25: NAND support
In-Reply-To: <cover.1263460321.git.baruch@tkos.co.il>
References: <cover.1263460321.git.baruch@tkos.co.il>
Message-ID: <20100114102440.GE23110@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2010 at 11:24:12AM +0200, Baruch Siach wrote:
> This patch series add support for NAND chips on the i.MX25 platform, using the 
> recently merged support for this platform in the mxc_nand driver.
> 
> I tested this code on the i.MX25 PDK platform.
> 
> Baruch Siach (3):
>   mtd: mxc_nand: add MX25 to Kconfig
>   mx25: add NAND support
>   mx25pdk: add NAND device support

Ok, added to mxc-master.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
