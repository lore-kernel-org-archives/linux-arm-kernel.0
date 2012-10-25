From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Oct 2012 10:55:07 +0200
Subject: [PATCH 1/5] ARM: Kirkwood: Allow use of pinctrl
In-Reply-To: <1351088724-11142-2-git-send-email-andrew@lunn.ch>
References: <1351088724-11142-1-git-send-email-andrew@lunn.ch>
 <1351088724-11142-2-git-send-email-andrew@lunn.ch>
Message-ID: <20121025105507.5bcb9eab@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Wed, 24 Oct 2012 16:25:20 +0200, Andrew Lunn wrote:

> index 7bf914d..5682c96 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -188,7 +188,7 @@ config PINCTRL_EXYNOS4
>  
>  config PINCTRL_MVEBU
>  	bool
> -	depends on ARCH_MVEBU
> +	depends on ARCH_MVEBU || ARCH_KIRKWOOD
>  	select PINMUX
>  	select PINCONF

Linus Walleij has accepted a patch I have sent yesterday evening that
makes PINCTRL_MVEBU available for all PLAT_ORION platforms, so this
chunk is no longer needed.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
