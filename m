From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Feb 2017 09:44:07 -0600
Subject: [PATCH v2 1/4] dt-bindings: add multidomain support to i.MX GPC
 DT binding
In-Reply-To: <20170127183728.26701-1-l.stach@pengutronix.de>
References: <20170127183728.26701-1-l.stach@pengutronix.de>
Message-ID: <20170201154407.m4otrkaucwjzhfmm@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 07:37:25PM +0100, Lucas Stach wrote:
> This adds a new binding for the Freescale i.MX GPC block, which allows
> to describe multiple power domains in a more natural way. The driver
> will continue to support the old binding for existing DTBs, but new
> features like the additional domains present on i.MX6SX will only be
> usable with the new binding.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> v2:
> - use 'power-supply' as name for the domain supply
> - clarify that 'pgc' is a node, not a property
> ---
>  .../devicetree/bindings/power/fsl,imx-gpc.txt      | 80 ++++++++++++++--------
>  1 file changed, 53 insertions(+), 27 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
