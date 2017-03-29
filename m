From: robh@kernel.org (Rob Herring)
Date: Wed, 29 Mar 2017 10:59:28 -0500
Subject: [PATCH 1/2] dt-bindings: imx-gpc: add i.MX6 QuadPlus compatible
In-Reply-To: <20170323144418.30977-2-l.stach@pengutronix.de>
References: <20170323144418.30977-1-l.stach@pengutronix.de>
 <20170323144418.30977-2-l.stach@pengutronix.de>
Message-ID: <20170329155928.5cjfhg5bl7xya3nn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 03:44:17PM +0100, Lucas Stach wrote:
> While the GPC on i.MX6QP is mostly comptible to the i.MX6Q one,
> the QuadPlus requires special workarounds for hardware erratum
> ERR009619.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/power/fsl,imx-gpc.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
