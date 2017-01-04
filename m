From: woogyom.kim@gmail.com (Milo Kim)
Date: Wed, 4 Jan 2017 16:12:56 +0900
Subject: [PATCH v4 2/3] ARM: dts: imx6: Support Savageboard dual
In-Reply-To: <20170104045553.26576-3-woogyom.kim@gmail.com>
References: <20170104045553.26576-1-woogyom.kim@gmail.com>
 <20170104045553.26576-3-woogyom.kim@gmail.com>
Message-ID: <5594e81c-a647-7d78-03bf-4ae10961fc17@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/04/2017 01:55 PM, Milo Kim wrote:
> Common savageboard DT file is used for board support.
> Add the vendor name and specify the dtb file for i.MX6Q build.
>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  arch/arm/boot/dts/Makefile                         |  1 +
>  arch/arm/boot/dts/imx6dl-savageboard.dts           | 51 ++++++++++++++++++++++
>  3 files changed, 53 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-savageboard.dts
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 16d3b5e7f5d1..88c33d827e51 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -227,6 +227,7 @@ pine64	Pine64
>  pixcir  PIXCIR MICROELECTRONICS Co., Ltd
>  plathome	Plat'Home Co., Ltd.
>  plda	PLDA
> +poslab  Poslab Technology Co., Ltd.

I should input tab here instead of spaces, so updated single patch was 
just sent. Please refer to the patch named "[PATCH resend v4 2/3] ARM: 
dts: imx6: Support Savageboard dual".

Sorry for the inconvenience.

Best regards,
Milo
