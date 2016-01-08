From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 8 Jan 2016 10:59:32 +0000
Subject: [PATCH v2 1/2] ARM: dts: imx6: Add support for Toradex Apalis
 iMX6Q/D SoM
In-Reply-To: <20160108085734.GC27359@ibawizard.net>
References: <1452011942-11940-1-git-send-email-marcel.ziswiler@toradex.com>
 <1452011942-11940-2-git-send-email-marcel.ziswiler@toradex.com>
 <20160108085734.GC27359@ibawizard.net>
Message-ID: <1452250771.3357.26.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-01-08 at 09:57 +0100, Petr ?tetiar wrote:
> > +	i2cddc: i2c at 0 {
> > +		gpios = <&gpio3 16 GPIO_ACTIVE_HIGH /* sda */
> > +			?&gpio2 30 GPIO_ACTIVE_HIGH /* scl */
> > +			>;
> 
> According to one of the comments, it should be changed to the
> following:
> 
> 		sda-gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
> 		scl-gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>;

No, I believe you mixed the i2c-imx binding with the i2c-gpio one [2].

> -- ynezz


[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/i2c/i2c-imx.txt
[2] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/i2c/i2c-gpio.txt

Cheers

Marcel
