From: horms@verge.net.au (Simon Horman)
Date: Wed, 14 Feb 2018 11:01:53 +0100
Subject: [PATCH 01/15] Documentation: devicetree: R-Car M3-N SoC DT
 bindings
In-Reply-To: <1518515162-23663-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-2-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180214100150.dv2fkffussrfqkme@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 10:45:48AM +0100, Jacopo Mondi wrote:
> Add device tree bindings documentation for Renesas R-Car M3-N (r8a77965)
> SoC.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks, this looks fine to me but I think the subject should be updated to

dt-bindings: arm: document R8A77965 SoC bindings

I'll let this sit for a few days to see if any other review is forthcoming.

> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> index 5c3af7e..7eb4830 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -39,6 +39,8 @@ SoCs:
>      compatible = "renesas,r8a7795"
>    - R-Car M3-W (R8A77960)
>      compatible = "renesas,r8a7796"
> +  - R-Car M3-N (R8A77965)
> +    compatible = "renesas,r8a77965"
>    - R-Car V3M (R8A77970)
>      compatible = "renesas,r8a77970"
>    - R-Car D3 (R8A77995)
> -- 
> 2.7.4
> 
