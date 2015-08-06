From: horms@verge.net.au (Simon Horman)
Date: Thu, 6 Aug 2015 09:37:51 +0900
Subject: [PATCH] ARM: shmobile: Add silk device tree bindings documentation
In-Reply-To: <1438723848-14812-1-git-send-email-horms+renesas@verge.net.au>
References: <1438723848-14812-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20150806003751.GC17231@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 06:30:48AM +0900, Simon Horman wrote:
> Add Silk Device tree bindings Documentation, listing it as a supported board.
> 
> This allows to use checkpatch to validate DTSes referring to the Silk board.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, I have queued this up for v4.4 rather than as a fix for v4.3
as it doesn't have any run or build time effect.

> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> index c4f19b2e7dd9..f3f96b5a7418 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -57,6 +57,8 @@ Boards:
>      compatible = "renesas,lager", "renesas,r8a7790"
>    - Marzen
>      compatible = "renesas,marzen", "renesas,r8a7779"
> +  - Silk
> +    compatible = "renesas,silk", "renesas,r8a7794";
>  
>  Note: Reference Device Tree Implementations are temporary implementations
>        to ease the migration from platform devices to Device Tree, and are
> -- 
> 2.1.4
> 
