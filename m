From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 19 Feb 2013 12:33:06 +0100
Subject: [PATCH v2 1/8] dt: describe base reset signal binding
In-Reply-To: <20130217130558.GC6782@S2101-09.ap.freescale.net>
References: <1360776872-18584-1-git-send-email-p.zabel@pengutronix.de>
 <1360776872-18584-2-git-send-email-p.zabel@pengutronix.de>
 <20130217130558.GC6782@S2101-09.ap.freescale.net>
Message-ID: <1361273586.4350.2.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Sonntag, den 17.02.2013, 21:05 +0800 schrieb Shawn Guo:
> On Wed, Feb 13, 2013 at 06:34:25PM +0100, Philipp Zabel wrote:
> > From: Stephen Warren <swarren@nvidia.com>
> > 
> > This binding is intended to represent the hardware reset signals present
> > internally in most IC (SoC, FPGA, ...) designs.
> > It consists of a binding for a reset controller device (provider), and a
> > pair of properties, "resets" and "reset-names", to link a device node
> > (consumer) to its reset controller via phandle, similarly to the clock
> > and interrupt bindings.
> > 
> > The reset controller has all information necessary to reset the consumer
> > device. That could be provided via device tree, or it could be implemented
> > in hardware.
> > The aim is to enable device drivers to request a framework API to issue a
> > reset simply by providing their struct device pointer as the most common
> > case.
> > 
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

thank you for the review. I have made the changes you suggested and will
resend, rebased onto next-20130219.

regards
Philipp
