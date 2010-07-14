From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 14 Jul 2010 08:58:48 +0200
Subject: [PATCH 0/3]Add imx51_3ds platform support
In-Reply-To: <1279026162-6634-1-git-send-email-jason77.wang@gmail.com>
References: <1279026162-6634-1-git-send-email-jason77.wang@gmail.com>
Message-ID: <20100714065848.GC26079@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 09:02:38PM +0800, Jason Wang wrote:
> part3:
> 
>  [PATCH 1/3] mx51_3ds: Add support for the imx51 3-stack board
>  [PATCH 2/3] mx51: add imx_keypad device definition for mx51 platforms
>  [PATCH 3/3] mx51_3ds: add keypad support on 3ds platform
>  This patchset will add imx51_3ds platform in the linux kernel,
>  These 3 patches are generated based off imx-for-2.6.36 branch,
>  and passed build test.
> 
>  But currently in imx-for-2.6.36 branch, there is a recently applied
>  patch which will affect all imx gpio chained irqs. The lan driver
>  on imx51_3ds can't raise irq(through gpio) because of this potential
>  issue. I generate the following patch to fix it.
>  [PATCH] imx: move gpio init after to irq init

Ok, except for the one comment I made

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
