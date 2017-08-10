From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 11:35:58 -0500
Subject: [PATCH 1/3] dt-bindings: net: c_can: Update binding for clock
 and power-domains property
In-Reply-To: <20170802201822.11532-2-fcooper@ti.com>
References: <20170802201822.11532-1-fcooper@ti.com>
 <20170802201822.11532-2-fcooper@ti.com>
Message-ID: <20170810163558.todxrky4f4nve57x@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 03:18:20PM -0500, Franklin S Cooper Jr wrote:
> CAN driver uses the clk_get_rate call to determine the frequency of the
> functional clock. OMAP based SoCs do not require the clock property since
> hwmod already handles creating a "fck" clock thats accessible to drivers.

that's

> However, this isn't the case for 66AK2G which makes the clocks property
> require for that SoC.

required

> 
> 66AK2G requires a new property. Therefore, update the binding to also make
> this property requirement clear. Also clarify that for OMAP based SoCs
> ti,hwmod is a required property.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  Documentation/devicetree/bindings/net/can/c_can.txt | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
