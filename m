From: robh@kernel.org (Rob Herring)
Date: Thu, 2 Jun 2016 17:45:50 -0500
Subject: [PATCH 1/3] dt-bindings: pwm: Add MediaTek display PWM bindings
In-Reply-To: <1464597712-5399-2-git-send-email-weiqing.kong@mediatek.com>
References: <1464597712-5399-1-git-send-email-weiqing.kong@mediatek.com>
 <1464597712-5399-2-git-send-email-weiqing.kong@mediatek.com>
Message-ID: <20160602224550.GA19256@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 04:41:50PM +0800, Weiqing Kong wrote:
> Add MT2701 compatible string.
> 
> Signed-off-by: Weiqing Kong <weiqing.kong@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> index f8f59ba..f2f2fa9 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> @@ -1,9 +1,10 @@
>  MediaTek display PWM controller
>  
>  Required properties:
> - - compatible: should be "mediatek,<name>-disp-pwm":
> -   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
> + - compatible: should be like these:
> +   - "mediatek,mt2701-disp-bls": found on mt2701 SoC.

Why bls instead of pwm?

>     - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
> +   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
>   - reg: physical base address and length of the controller's registers.
>   - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
>     the cell format.
> -- 
> 1.8.1.1.dirty
> 
