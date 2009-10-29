From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 29 Oct 2009 08:32:56 +0100
Subject: i.MX35 NANDFC implementation?
In-Reply-To: <80tyxjfg7e.fsf@merkur.tec.linutronix.de>
References: <80tyxjfg7e.fsf@merkur.tec.linutronix.de>
Message-ID: <20091029073256.GJ15296@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2009 at 08:53:25PM +0100, John Ogness wrote:
> Hi,
> 
> I am implementing the NAND Flash Controller for for the i.MX35 on a PDK
> board from Freescale. I couldn't find any existing implementation
> anywhere, but maybe one of you is also working on it? If so, please let
> me know so we can work together on it.

First please note that the mailing list address has changed. Find the
correct address in cc.

I recently created patches for i.MX35 Nand support. I posted them to the
mtd list and you can find them here via git:

git://git.pengutronix.de/git/imx/linux-2.6.git mxc-nand

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
