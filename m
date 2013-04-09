From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 09 Apr 2013 10:16:08 +0200
Subject: [PATCH v6 1/8] dt: describe base reset signal binding
In-Reply-To: <515D84D6.8090107@gmail.com>
References: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
 <1364488523-20310-2-git-send-email-p.zabel@pengutronix.de>
 <515D84D6.8090107@gmail.com>
Message-ID: <1365495368.4023.29.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Am Donnerstag, den 04.04.2013, 08:49 -0500 schrieb Rob Herring:
> On 03/28/2013 11:35 AM, Philipp Zabel wrote:
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
> > Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
> > Reviewed-by: Marek Vasut <marex@denx.de>
> 
> Looks good.
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Thank you. I'll not add the Acked-by: line to the patch itself, if
that's ok, since Shawn already pulled it into his imx/soc branch.

regards
Philipp
