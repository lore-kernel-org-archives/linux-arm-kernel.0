From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 25 May 2011 19:46:31 +0800
Subject: [PATCH] arm: mxs: include asm/processor.h for cpu_relax()
In-Reply-To: <1306316097-27926-1-git-send-email-w.sang@pengutronix.de>
References: <1306316097-27926-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20110525114631.GC2408@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2011 at 11:34:57AM +0200, Wolfram Sang wrote:
> I get this build error as of today:
> 
> arch/arm/mach-mxs/ocotp.c: In function 'mxs_get_ocotp':
> arch/arm/mach-mxs/ocotp.c:54: error: implicit declaration of function 'cpu_relax'
> make[2]: *** [arch/arm/mach-mxs/ocotp.o] Error 1
> 
> Looks like it has been indirectly included before which broke now.
> Include it directly.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> ---
Acked-by: Shawn Guo <shawn.guo@freescale.com>

-- 
Regards,
Shawn
