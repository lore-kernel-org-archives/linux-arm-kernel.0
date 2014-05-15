From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 15 May 2014 15:08:31 +0200
Subject: [PATCH 3/3] ARM: dts: kirkwood: add kirkwood-km_fixedeth DTS file
In-Reply-To: <1400147335-20947-4-git-send-email-valentin.longchamp@keymile.com>
References: <1400147335-20947-1-git-send-email-valentin.longchamp@keymile.com>
 <1400147335-20947-4-git-send-email-valentin.longchamp@keymile.com>
Message-ID: <20140515130831.GC32684@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	i2c at 0 {
> +		compatible = "i2c-gpio";
> +		gpios = < &gpio0 8 GPIO_ACTIVE_HIGH		/* sda */
> +			  &gpio0 9 GPIO_ACTIVE_HIGH>;		/* scl */
> +		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
> +	};

Hi Valentin

Anything interesting on the i2c bus?

Does this SoC not have the hardware i2c? I don't see a node for it
here.

Thanks
	Andrew
