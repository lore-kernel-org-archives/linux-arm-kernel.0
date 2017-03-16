From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 16 Mar 2017 09:28:23 +0100
Subject: [PATCH v1 2/7] dt-bindings: iio: rockchip-saradc: add support for
 rk3328
In-Reply-To: <1489572237-6649-3-git-send-email-cl@rock-chips.com>
References: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
 <1489572237-6649-3-git-send-email-cl@rock-chips.com>
Message-ID: <8664375.8vdE6CQfX9@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 15. M?rz 2017, 18:03:52 CET schrieb cl at rock-chips.com:
> From: Chen Liang <cl@rock-chips.com>
> 
> The rk3328 saradc is the same as rk3399.
> 
> Signed-off-by: Chen Liang <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt index
> 205593f..f81bc20 100644
> --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> @@ -5,6 +5,7 @@ Required properties:
>     - "rockchip,saradc": for rk3188, rk3288
>     - "rockchip,rk3066-tsadc": for rk3036
>     - "rockchip,rk3399-saradc": for rk3399
> +   - "rockchip,rk3328-saradc", "rockchip,rk3399-saradc": for rk3328

not sure how iio people see that, but I would suggest keeping the order, so 
put rk3328 above rk3399.

Heiko
