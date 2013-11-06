From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 6 Nov 2013 08:21:33 +0100
Subject: [RFC PATCH 3/3] ARM: imx: cpuidle: Move the drivers to
 drivers/cpuidle
In-Reply-To: <1382978973-4034-3-git-send-email-daniel.lezcano@linaro.org>
References: <1382978973-4034-1-git-send-email-daniel.lezcano@linaro.org>
 <1382978973-4034-3-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20131106072132.GE24559@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

On Mon, Oct 28, 2013 at 09:49:33AM -0700, Daniel Lezcano wrote:
> +
> +config ARM_IMX5_CPUIDLE
> +        bool "Cpu Idle Driver for the IMX5 processors"
> +	default y
> +	depends on SOC_IMX5 
> +	help
> +	  Select this to enable cpuidle for IMX5 processors
> +
> +config ARM_IMX6Q_CPUIDLE
> +        bool "Cpu Idle Driver for the IMX6Q processors"
> +	default y
> +	depends on SOC_IMX6Q
> +	help
> +	  Select this to enable cpuidle for IMX6Q processors

I can't say much to this series except there's some whitespace damage
here. Please resend this series with Cc: Shawn Guo <shawn.guo@linaro.org>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
