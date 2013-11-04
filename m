From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 4 Nov 2013 17:15:47 +0800
Subject: [PATCHv2 7/7] ARM: dts: imx: add device tree support for
 Freescale imx50evk board
In-Reply-To: <1383023757-30711-8-git-send-email-gerg@uclinux.org>
References: <1383023757-30711-1-git-send-email-gerg@uclinux.org>
 <1383023757-30711-8-git-send-email-gerg@uclinux.org>
Message-ID: <20131104091545.GA24970@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 03:15:57PM +1000, gerg at uclinux.org wrote:
> +&usbh1 {
> +	pinctrl-names = "default";

It does not make any sense to have this property when there is no
pinctrl-0 phandle pointing to a real pinctrl setup.

I just fixed it up to drop the property for these nodes.

Shawn

> +	status = "okay";
> +};
> +
> +&usbh2 {
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&usbh3 {
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> -- 
> 1.8.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
