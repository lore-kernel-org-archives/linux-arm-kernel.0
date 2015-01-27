From: horms@verge.net.au (Simon Horman)
Date: Tue, 27 Jan 2015 10:17:14 +0900
Subject: [PATCH 04/14 v2] ARM: shmobile: mackerel: Remove DT binding
 documentation
In-Reply-To: <20150126061829.6848.75172.sendpatchset@little-apple>
References: <20150126061747.6848.9708.sendpatchset@little-apple>
 <20150126061829.6848.75172.sendpatchset@little-apple>
Message-ID: <20150127011713.GE29710@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 03:18:29PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Remove the DT compatibile string documentation for the

I have taken the liberty of changing compatibile to compatible
while queuing up this patch.

> no longer supported Mackerel board.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> 
>  Changes since V1:
>  - None
> 
>  Documentation/devicetree/bindings/arm/shmobile.txt |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- 0001/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ work/Documentation/devicetree/bindings/arm/shmobile.txt	2015-01-21 11:10:46.507575167 +0900
> @@ -57,8 +57,6 @@ Boards:
>      compatible = "renesas,kzm9g", "renesas,sh73a0"
>    - Lager (RTP0RC7790SEB00010S)
>      compatible = "renesas,lager", "renesas,r8a7790"
> -  - Mackerel (R0P7372LC0016RL, AP4 EVM 2nd)
> -    compatible = "renesas,mackerel"
>    - Marzen
>      compatible = "renesas,marzen", "renesas,r8a7779"
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
