From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 30 Jul 2018 17:06:32 +0200
Subject: [PATCH v2 2/6] dt-bindings: mmc: rockchip-dw-mshc: add
 description for px30
In-Reply-To: <1532337924-4185-3-git-send-email-cl@rock-chips.com>
References: <1532337924-4185-1-git-send-email-cl@rock-chips.com>
 <1532337924-4185-3-git-send-email-cl@rock-chips.com>
Message-ID: <CAPDyKFo2GmxKwXDTOxnNY_wb4ydmVjGAZD3=bZYLhfEvjmGyXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 July 2018 at 11:25,  <cl@rock-chips.com> wrote:
> From: Liang Chen <cl@rock-chips.com>
>
> Add "rockchip,px30-dw-mshc", "rockchip,rk3288-dw-mshc" for
> dwmmc on px30 platform.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Liang Chen <cl@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> index 8ce49b2..6f629b1 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> @@ -14,6 +14,7 @@ Required Properties:
>                                                         before RK3288
>         - "rockchip,rk3288-dw-mshc": for Rockchip RK3288
>         - "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RV1108
> +       - "rockchip,px30-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip PX30
>         - "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3036
>         - "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK322x
>         - "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3328
> --
> 1.9.1
>
>
