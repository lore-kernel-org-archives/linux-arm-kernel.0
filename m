From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 24 Sep 2011 01:11:33 +0800
Subject: [PATCH] i.MX: use CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1316522956-28530-1-git-send-email-s.hauer@pengutronix.de>
References: <1316522956-28530-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110923171131.GA15511@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 02:49:12PM +0200, Sascha Hauer wrote:
> The following series switches the i.MX architecture to use
> CONFIG_MULTI_IRQ_HANDLER. This allows us to compile a kernel
> with i.MX3 and i.MX5 support in a later series. Also, it will
> help with the i.MX6 support which has a different irq controller.
> 
Hi Sascha,

I just sent a patch to get GIC support with CONFIG_MULTI_IRQ_HANDLER
based on your series.  If the patch looks good to people, you may
want to fold it into the series?

-- 
Regards,
Shawn
