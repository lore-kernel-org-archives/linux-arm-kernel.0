From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 6 Aug 2012 11:00:16 +0800
Subject: [PATCH] clk: mxs: Register USB clocks for mx23
In-Reply-To: <CAOMZO5AaLKN9bhuPRLJkA8ytiwVi_yrpwzL0mJAzf6VS4PSRLQ@mail.gmail.com>
References: <1340148392-9847-1-git-send-email-festevam@gmail.com>
 <20120620143830.GF2253@S2101-09.ap.freescale.net>
 <CAOMZO5AaLKN9bhuPRLJkA8ytiwVi_yrpwzL0mJAzf6VS4PSRLQ@mail.gmail.com>
Message-ID: <20120806030014.GB22302@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 05, 2012 at 02:08:07PM -0300, Fabio Estevam wrote:
> On Wed, Jun 20, 2012 at 11:38 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> ...
> >> +     clk_register_clkdev(clks[usb_pwr], NULL, "8007c000.usbphy");
> >> +     clk_register_clkdev(clks[usb], NULL, "80080000.usb");
> >
> > It depends on the node name in device tree.  I would defer this
> > a little bit to have the node name in dts settled down first.
> 
> Now that the mxs usb driver is in mainline, could this patch be applied?
> 
Probably, no, as I plan to freeze the addition to clkdev lookup table
and replace it with DT clock lookup.

-- 
Regards,
Shawn
