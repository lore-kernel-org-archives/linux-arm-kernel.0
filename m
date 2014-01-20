From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 20 Jan 2014 15:23:14 +0100
Subject: [PATCH] dt-bindings: add rockchip vendor prefix
In-Reply-To: <201312201626.48119.heiko@sntech.de>
References: <201312201626.48119.heiko@sntech.de>
Message-ID: <2229282.4AAJ7iLdU7@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 20. Dezember 2013, 16:26:47 schrieb Heiko St?bner:
> It seems I forgot to add the vendor prefix for rockchip to the vendor-prefix
> list. Therefore add it now.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

not sure, where this should go through
arm-soc? or is there a special dt-tree around?


Thanks
Heiko

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> b/Documentation/devicetree/bindings/vendor-prefixes.txt index
> ca2c190..2dc3b75 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -65,6 +65,7 @@ ralink	Mediatek/Ralink Technology Corp.
>  ramtron	Ramtron International
>  realtek Realtek Semiconductor Corp.
>  renesas	Renesas Electronics Corporation
> +rockchip	Fuzhou Rockchip Electronics Co., Ltd
>  samsung	Samsung Semiconductor
>  sbs	Smart Battery System
>  schindler	Schindler
