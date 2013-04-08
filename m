From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Apr 2013 14:33:42 +0800
Subject: [PATCH 1/3] ARM: dts: Add NFC support for i.MX27 Phytec PCM038
 module
In-Reply-To: <1365348554-24345-1-git-send-email-shc_work@mail.ru>
References: <1365348554-24345-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130408063340.GB5047@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 07, 2013 at 07:29:12PM +0400, Alexander Shiyan wrote:
> Added NFC node to imx27-phytec-phycore DT file.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, thanks.

> ---
>  arch/arm/boot/dts/imx27-phytec-phycore.dtsp | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dtsp b/arch/arm/boot/dts/imx27-phytec-phycore.dtsp
> index 924097a..7228153 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycore.dtsp
> +++ b/arch/arm/boot/dts/imx27-phytec-phycore.dtsp
> @@ -71,3 +71,9 @@
>  		#size-cells = <1>;
>  	};
>  };
> +
> +&nfc {
> +	nand-bus-width = <8>;
> +	nand-ecc-mode = "hw";
> +	status = "okay";
> +};
> -- 
> 1.8.1.5
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
