From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 17 Jan 2012 20:44:11 +0100
Subject: booting hangs after enabling CONFIG_EARLY_PRINTK
In-Reply-To: <loom.20120117T121146-86@post.gmane.org>
References: <loom.20120117T121146-86@post.gmane.org>
Message-ID: <20120117194411.GK14252@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jan 17, 2012 at 11:22:06AM +0000, shabbir wrote:
> Hi Russel
note that Russell likes his name being spelled correctly.

>  I have ported linux 3.0 kernel to ARM board,it is successfully booting,but when
> i enabled the CONFIG_EARLY_PRINTK in kernel hacking->kernel debugging->kernel
> low level debugging from make menuconfig,kernel booting hangs after
> Uncompressing linux...done,booting the kernel.But the same thing when i have
> tested with ARM versatile PB board everything works fine,i dont know what's
> wrong with my board.Please help me in this isssue
This is probably a problem with your definitions in
include/mach/debug-macro.S. It's hard to say more without details about
your machine and and your debug-macro.S file.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
