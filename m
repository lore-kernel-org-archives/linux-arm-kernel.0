From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Sun, 13 May 2018 15:11:17 +0200
Subject: [PATCH] media: rcar-vin:  Drop unnecessary register properties
 from example vin port
In-Reply-To: <20180509184558.14960-1-horms+renesas@verge.net.au>
References: <20180509184558.14960-1-horms+renesas@verge.net.au>
Message-ID: <20180513131117.GR18974@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thanks for your patch.

On 2018-05-09 20:45:58 +0200, Simon Horman wrote:
> The example vin port node does not have an address and thus does not
> need address-cells or address size-properties.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  Documentation/devicetree/bindings/media/rcar_vin.txt | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
> index a19517e1c669..2a0c59e97f40 100644
> --- a/Documentation/devicetree/bindings/media/rcar_vin.txt
> +++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
> @@ -107,9 +107,6 @@ Board setup example for Gen2 platforms (vin1 composite video input)
>          status = "okay";
>  
>          port {
> -                #address-cells = <1>;
> -                #size-cells = <0>;
> -
>                  vin1ep0: endpoint {
>                          remote-endpoint = <&adv7180>;
>                          bus-width = <8>;
> -- 
> 2.11.0
> 

-- 
Regards,
Niklas S?derlund
