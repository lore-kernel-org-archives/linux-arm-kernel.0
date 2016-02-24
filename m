From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 24 Feb 2016 10:50:15 -0600
Subject: [PATCH] dts: add specific compatible type for Terasic DE0-NANO-SoC
 Board
In-Reply-To: <8416439.76b9YNhpgR@dabox>
References: <8416439.76b9YNhpgR@dabox>
Message-ID: <alpine.DEB.2.02.1602241048100.3815@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

On Fri, 12 Feb 2016, Tim Sander wrote:

> From: Tim Sander <tim@krieglstein.org>
> 
> Add a more specific compatible string:"terasic,de0-nano-soc" for respective board.
> Background: when checking for bootspec entries, some board specific fixups
>                          are not apropriate for board of the same platform ("altr,socfpga-cyclone5").
>                         The same aproach is taken with the EBV-Socrates board.
>

Please fix up the spacing in the commit message.

> Signed-off-by: Tim Sander <tim@krieglstein.org>
> ---
>  arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> index 555e9caf21e1..3a427423168e 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> @@ -18,7 +18,7 @@
>  
>  / {
>         model = "Terasic DE-0(Atlas)";
> -       compatible = "altr,socfpga-cyclone5", "altr,socfpga";
> +       compatible = "terasic,de0-nano-soc"," altr,socfpga-cyclone5", "altr,socfpga";
> 

"terasic" is not listed in Documentation/devicetree/bindings/vendor-prefixes.txt.
 
BR,
Dinh
