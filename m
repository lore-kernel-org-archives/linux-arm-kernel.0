From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 19 Mar 2018 02:32:56 +0100
Subject: [PATCH v2 1/5] dt-bindings: soc: update MT2712 power dt-bindings
In-Reply-To: <20180312070342.4335-3-weiyi.lu@mediatek.com>
References: <20180312070342.4335-1-weiyi.lu@mediatek.com>
 <20180312070342.4335-3-weiyi.lu@mediatek.com>
Message-ID: <a80922c9-3feb-c3f1-d1f1-1673a57d5795@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/12/2018 08:03 AM, Weiyi Lu wrote:
> Add new power domains(MFG_SC1/MFG_SC2/MFG_SC3)
> for MT2712 according to ECO design change.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Pushed to v4.16-next/soc

Thanks!

> ---
>  include/dt-bindings/power/mt2712-power.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/power/mt2712-power.h b/include/dt-bindings/power/mt2712-power.h
> index 92b46d772fae..2c147817efc2 100644
> --- a/include/dt-bindings/power/mt2712-power.h
> +++ b/include/dt-bindings/power/mt2712-power.h
> @@ -22,5 +22,8 @@
>  #define MT2712_POWER_DOMAIN_USB		5
>  #define MT2712_POWER_DOMAIN_USB2	6
>  #define MT2712_POWER_DOMAIN_MFG		7
> +#define MT2712_POWER_DOMAIN_MFG_SC1	8
> +#define MT2712_POWER_DOMAIN_MFG_SC2	9
> +#define MT2712_POWER_DOMAIN_MFG_SC3	10
>  
>  #endif /* _DT_BINDINGS_POWER_MT2712_POWER_H */
> 
