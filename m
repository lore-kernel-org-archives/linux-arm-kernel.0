From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Mar 2016 17:39:04 -0600
Subject: [PATCH -trivial] devicetree: bindings: ARM: Use "uV" for
 micro-volt
In-Reply-To: <1455540282-23619-1-git-send-email-geert+renesas@glider.be>
References: <1455540282-23619-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20160303233904.GA14751@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 01:44:42PM +0100, Geert Uytterhoeven wrote:
> The binding documentation uses both "uVolt" and "uV" for micro-volt.
> Improve consistency by settling on "uV".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks.

Rob

> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index ae9be074d09f66d5..afcf50f050ad3f56 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -250,7 +250,7 @@ nodes to be present and contain the properties described below.
>  		Usage: optional
>  		Value type: <prop-encoded-array>
>  		Definition: A u32 value that represents the running time dynamic
> -			    power coefficient in units of mW/MHz/uVolt^2. The
> +			    power coefficient in units of mW/MHz/uV^2. The
>  			    coefficient can either be calculated from power
>  			    measurements or derived by analysis.
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
