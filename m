From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 21 Nov 2015 21:14:11 +0100
Subject: [RFC PATCH v1 2/2] dt-bindings: add document for Innosilicon HDMI
 on Rockchip platform
In-Reply-To: <1447228052-4897-1-git-send-email-ykk@rock-chips.com>
References: <1447227952-4787-1-git-send-email-ykk@rock-chips.com>
 <1447228052-4897-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1776316.RzHCH7Zejb@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,

Am Mittwoch, 11. November 2015, 15:47:32 schrieb Yakir Yang:
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
>  .../display/rockchip/inno_hdmi-rockchip.txt        | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
> new file mode 100644
> index 0000000..1898408
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
> @@ -0,0 +1,50 @@
> +Rockchip specific extensions to the Innosilicon HDMI
> +================================
> +
> +Required properties:
> +- compatible:
> +	"rockchip,rk3036-dw-hdmi";

should be "rockchip,rk3036-inno-hdmi"; instead I guess


Heiko
