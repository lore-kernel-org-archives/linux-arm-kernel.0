From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 22 May 2012 14:08:31 +0800
Subject: [PATCH v2 08/12] ARM: imx6q: add usbphy clocks
In-Reply-To: <20120522053706.GO8140@S2101-09.ap.freescale.net>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-9-git-send-email-richard.zhao@freescale.com>
 <20120522053706.GO8140@S2101-09.ap.freescale.net>
Message-ID: <20120522060830.GT6206@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 01:37:08PM +0800, Shawn Guo wrote:
> On Mon, May 21, 2012 at 05:23:53PM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  arch/arm/mach-imx/clk-imx6q.c |    7 ++++++-
> >  1 files changed, 6 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> > index f99509a..0d003aa 100644
> > --- a/arch/arm/mach-imx/clk-imx6q.c
> > +++ b/arch/arm/mach-imx/clk-imx6q.c
> > @@ -152,7 +152,7 @@ enum mx6q_clks {
> >  	ssi2, ssi3, uart_ipg, uart_serial, usboh3, usdhc1, usdhc2, usdhc3,
> >  	usdhc4, vdo_axi, vpu_axi, cko1, pll1_sys, pll2_bus, pll3_usb_otg,
> >  	pll4_audio, pll5_video, pll6_mlb, pll7_usb_host, pll8_enet, ssi1_ipg,
> > -	ssi2_ipg, ssi3_ipg, clk_max
> > +	ssi2_ipg, ssi3_ipg, usbphy1_gate, usbphy2_gate, clk_max
> 
> Can you drop the "_gate" suffix?  We do not have such suffix for leaf
> clock in imx6q clock file.
ok

Thanks
Richard
 
