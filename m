From: robh@kernel.org (Rob Herring)
Date: Fri, 2 Sep 2016 10:19:55 -0500
Subject: [PATCH] arm64: renesas: r8a7796/salvator-x: Add board part
 number to DT bindings
In-Reply-To: <1472635054-24372-1-git-send-email-geert+renesas@glider.be>
References: <1472635054-24372-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20160902151955.GA27150@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 11:17:34AM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> index 90cf237ee5581978..42a046a97acba00f 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -65,7 +65,7 @@ Boards:
>      compatible = "renesas,porter", "renesas,r8a7791"
>    - Salvator-X (RTP0RC7795SIPB0010S)
>      compatible = "renesas,salvator-x", "renesas,r8a7795";
> -  - Salvator-X
> +  - Salvator-X (RTP0RC7796SIPB0011S)
>      compatible = "renesas,salvator-x", "renesas,r8a7796";

Seems like these should be different compatibles rather than the 
combination here defining exactly which board. 

>    - SILK (RTP0RC7794LCB00011S)
>      compatible = "renesas,silk", "renesas,r8a7794"
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
