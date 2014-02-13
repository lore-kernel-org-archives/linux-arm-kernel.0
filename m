From: nm@ti.com (Nishanth Menon)
Date: Thu, 13 Feb 2014 08:43:53 -0600
Subject: [PATCH v2 4/4] Documentation: dt: OMAP: Update Overo/Tobi
In-Reply-To: <1392287116-4548-5-git-send-email-florian.vaussard@epfl.ch>
References: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch>
 <1392287116-4548-5-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <52FCDA29.90605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2014 04:25 AM, Florian Vaussard wrote:
> Update the compatible string for Overo/Tobi to reflect the latest
> changes.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  Documentation/devicetree/bindings/arm/omap/omap.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index 34dc40c..af9b4a0 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -91,7 +91,7 @@ Boards:
>    compatible = "ti,omap3-beagle", "ti,omap3"
>  
>  - OMAP3 Tobi with Overo : Commercial expansion board with daughter board
> -  compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap3"
> +  compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3"
omap3-overo-storm-tobi.dts is not covered here, so, I wonder as the
number of boards supported keep increasing, is'nt it better we drop
the board information from omap.txt?

>  
>  - OMAP4 SDP : Software Development Board
>    compatible = "ti,omap4-sdp", "ti,omap4430"
> 
-- 
Regards,
Nishanth Menon
