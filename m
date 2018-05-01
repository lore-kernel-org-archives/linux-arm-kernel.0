From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 11:22:12 -0500
Subject: [PATCH 12/21] bindings: display: Add compatible for A64 tcon-tv
In-Reply-To: <20180430114058.5061-13-jagan@amarulasolutions.com>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-13-jagan@amarulasolutions.com>
Message-ID: <20180501162212.GA6950@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2018 at 05:10:49PM +0530, Jagan Teki wrote:
> tcon-tv on Allwinner A64 has similar behavior like Allwinner A83T.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index 5d448ef2132f..8b6b4bc43d98 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -150,6 +150,7 @@ Required properties:
>     * allwinner,sun8i-v3s-tcon
>     * allwinner,sun9i-a80-tcon-lcd
>     * allwinner,sun9i-a80-tcon-tv
> +   * allwinner,sun50i-a64-tcon-tv

Fallback?

>   - reg: base address and size of memory-mapped region
>   - interrupts: interrupt associated to this IP
>   - clocks: phandles to the clocks feeding the TCON.
> -- 
> 2.14.3
> 
