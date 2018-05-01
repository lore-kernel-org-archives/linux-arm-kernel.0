From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 11:21:30 -0500
Subject: [PATCH 11/21] bindings: display: Add compatible for A64 Mixer1
In-Reply-To: <20180430114058.5061-12-jagan@amarulasolutions.com>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-12-jagan@amarulasolutions.com>
Message-ID: <20180501162130.GA6219@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2018 at 05:10:48PM +0530, Jagan Teki wrote:
> Mixer1 on Allwinner A64 has similar behavior like Allwinner A83T.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index 7dcd1d64dfe4..5d448ef2132f 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -313,6 +313,7 @@ Required properties:
>      * allwinner,sun8i-a83t-de2-mixer-1
>      * allwinner,sun8i-h3-de2-mixer-0
>      * allwinner,sun8i-v3s-de2-mixer
> +    * allwinner,sun50i-a64-de2-mixer-1

Need to capture fallbacks here.

>    - reg: base address and size of the memory-mapped region.
>    - clocks: phandles to the clocks feeding the mixer
>      * bus: the mixer interface clock
> -- 
> 2.14.3
> 
