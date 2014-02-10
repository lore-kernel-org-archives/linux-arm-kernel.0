From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 10 Feb 2014 18:37:59 +0100
Subject: [PATCH 05/11] ARM: mvebu: add Device Tree for the Armada 375 DB
 board
In-Reply-To: <1392053002-19831-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392053002-19831-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140210173759.GB9995@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas

> +			mvsdio at d4000 {
> +				pinctrl-0 = <&sdio_pins &sdio_st_pins>;
> +				pinctrl-names = "default";
> +				status = "okay";
> +				cd-gpios = <&gpio1 12 0>;
> +				wp-gpios = <&gpio1 13 0>;

Kirkwood recently started using include/dt-bindings/gpio/gpio.h. Maybe
you can do the same here?

    Andrew
