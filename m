From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 5 Nov 2009 14:43:25 +0100
Subject: [RFC PATCH] Add an earlyprintk debug console
In-Reply-To: <20091105123448.27637.97119.stgit@pc1117.cambridge.arm.com>
References: <20091105123448.27637.97119.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091105134325.GQ30179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2009 at 12:35:12PM +0000, Catalin Marinas wrote:
> This patch allows an earlyprintk console if CONFIG_DEBUG_LL is enabled,
> using the printch asm function.
> 
> The patch is based on the original work by Sascha Hauer.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> 
> The first variant of this patch was posted earlier this year -
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/52478 - and there
> were a few comments but no follow-up patch. I implemented those
> comments and I think we should merge this (it's much easier to pass
> earlyprintk on the kernel command line than hacking the printk code to
> do a printascii).

Nice :)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
