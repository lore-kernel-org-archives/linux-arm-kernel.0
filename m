From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 25 May 2011 18:44:50 +0800
Subject: [PATCH] arm: mxs: include asm/processor.h for cpu_relax()
In-Reply-To: <1306316097-27926-1-git-send-email-w.sang@pengutronix.de>
References: <1306316097-27926-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20110525104449.GA2408@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Wed, May 25, 2011 at 11:34:57AM +0200, Wolfram Sang wrote:
> I get this build error as of today:
> 
> arch/arm/mach-mxs/ocotp.c: In function 'mxs_get_ocotp':
> arch/arm/mach-mxs/ocotp.c:54: error: implicit declaration of function 'cpu_relax'
> make[2]: *** [arch/arm/mach-mxs/ocotp.o] Error 1
> 
May I know the tree you are seeing this error with?

-- 
Regards,
Shawn
