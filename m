From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Dec 2013 14:49:59 +0800
Subject: [PATCH 2/2] ARM: dts: Add support for the i.MX35.
In-Reply-To: <1387375826-4018-3-git-send-email-s.hauer@pengutronix.de>
References: <1387375826-4018-1-git-send-email-s.hauer@pengutronix.de>
 <1387375826-4018-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20131219064957.GZ6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 03:10:26PM +0100, Sascha Hauer wrote:
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ckil {
> +			compatible = "fsl,imx-ckil", "fixed-clock";
> +			clock-frequency = <32768>;
> +		};
> +
> +		osc {
> +			compatible = "fsl,imx-osc", "fixed-clock";
> +			clock-frequency = <24000000>;
> +		};

I asked the question in the last round, but did not get any answer.  Do
these two clocks exist on imx35?  At least from the imx35 clock code,
I do not see them.

Shawn

> +	};
