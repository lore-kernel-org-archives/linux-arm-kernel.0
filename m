From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Apr 2016 08:44:09 -0500
Subject: [PATCH 10/14] misc: sram: DT spelling
 s/#adress-cells/#address-cells/
In-Reply-To: <1461166339-11109-11-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
 <1461166339-11109-11-git-send-email-geert+renesas@glider.be>
Message-ID: <20160425134409.GA4060@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 05:32:15PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks.

Rob

> ---
>  Documentation/devicetree/bindings/sram/sram.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sram/sram.txt b/Documentation/devicetree/bindings/sram/sram.txt
> index 227e3a341af1e2b5..add48f09015e212e 100644
> --- a/Documentation/devicetree/bindings/sram/sram.txt
> +++ b/Documentation/devicetree/bindings/sram/sram.txt
> @@ -51,7 +51,7 @@ sram: sram at 5c000000 {
>  	compatible = "mmio-sram";
>  	reg = <0x5c000000 0x40000>; /* 256 KiB SRAM at address 0x5c000000 */
>  
> -	#adress-cells = <1>;
> +	#address-cells = <1>;
>  	#size-cells = <1>;
>  	ranges = <0 0x5c000000 0x40000>;
>  
> -- 
> 1.9.1
> 
