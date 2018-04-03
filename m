From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 04 Apr 2018 01:19:33 +0300
Subject: [PATCH v2 1/5] dt-bindings: display: bridge: lvds-transmitter:
 add ti, ds90c185
In-Reply-To: <20180326212447.7380-2-peda@axentia.se>
References: <20180326212447.7380-1-peda@axentia.se>
 <20180326212447.7380-2-peda@axentia.se>
Message-ID: <6322311.C1mXSAZMCy@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Thank you for the patch.

On Tuesday, 27 March 2018 00:24:43 EEST Peter Rosin wrote:
> Start list of actual chips compatible with "lvds-encoder".
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../devicetree/bindings/display/bridge/lvds-transmitter.txt       | 8 ++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> index fd39ad34c383..50220190c203 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> @@ -22,7 +22,13 @@ among others.
> 
>  Required properties:
> 
> -- compatible: Must be "lvds-encoder"
> +- compatible: Must be one or more of the following
> +  - "ti,ds90c185" for the TI DS90C185 FPD-Link Serializer
> +  - "lvds-encoder" for a generic LVDS encoder device
> +
> +  When compatible with the generic version, nodes must list the
> +  device-specific version corresponding to the device first
> +  followed by the generic version.
> 
>  Required nodes:


-- 
Regards,

Laurent Pinchart
