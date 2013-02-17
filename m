From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 17 Feb 2013 21:05:59 +0800
Subject: [PATCH v2 1/8] dt: describe base reset signal binding
In-Reply-To: <1360776872-18584-2-git-send-email-p.zabel@pengutronix.de>
References: <1360776872-18584-1-git-send-email-p.zabel@pengutronix.de>
 <1360776872-18584-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130217130558.GC6782@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 06:34:25PM +0100, Philipp Zabel wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This binding is intended to represent the hardware reset signals present
> internally in most IC (SoC, FPGA, ...) designs.
> It consists of a binding for a reset controller device (provider), and a
> pair of properties, "resets" and "reset-names", to link a device node
> (consumer) to its reset controller via phandle, similarly to the clock
> and interrupt bindings.
> 
> The reset controller has all information necessary to reset the consumer
> device. That could be provided via device tree, or it could be implemented
> in hardware.
> The aim is to enable device drivers to request a framework API to issue a
> reset simply by providing their struct device pointer as the most common
> case.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
