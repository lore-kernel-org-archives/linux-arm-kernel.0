From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 22 May 2012 12:52:43 +0800
Subject: [PATCH v2 12/12] ARM: dts: imx28-evk: add usb devices
In-Reply-To: <1337592237-5090-13-git-send-email-richard.zhao@freescale.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-13-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120522045240.GM8140@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 05:23:57PM +0800, Richard Zhao wrote:
>  	ahb at 80080000 {
> +		usb0: usb at 80080000 {
> +			fsl,vbus-power = <&gpio3 9 0>;

fsl,vbus-power-gpios

> +			status = "okay";
> +		};
> +
> +		usb1: usb at 80090000 {
> +			fsl,vbus-power = <&gpio3 8 0>;

Ditto

> +			status = "okay";
> +		};
> +

-- 
Regards,
Shawn
