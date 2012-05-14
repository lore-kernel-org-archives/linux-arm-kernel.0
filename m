From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 May 2012 16:18:26 +0800
Subject: [PATCH 1/1] ARM: imx6q: prepare and enable init on clks directly
 instead of clk_get first
In-Reply-To: <20120514072934.GA21318@pengutronix.de>
References: <1336971887-24616-1-git-send-email-richard.zhao@freescale.com>
 <20120514072934.GA21318@pengutronix.de>
Message-ID: <20120514081825.GC20367@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha,

On Mon, May 14, 2012 at 09:29:34AM +0200, Buddhi wrote:
> > +static enum mx6q_clks const clks_init_on[] __initconst = {
> > +	mmdc_ch0_axi, mmdc_ch1_axi, usboh3,
> > +};
> 
> BTW, why usboh3? Do we need this? Right now we do not have USB support
> on i.MX6. Once we have it the clock should be turned on in the USB
> driver, right?
> 
I remember that I have no usboh3 in clks_init_on when I handed the patch
over to you.

-- 
Regards,
Shawn
