From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Fri, 8 Jan 2016 09:57:34 +0100
Subject: [PATCH v2 1/2] ARM: dts: imx6: Add support for Toradex Apalis
 iMX6Q/D SoM
In-Reply-To: <1452011942-11940-2-git-send-email-marcel.ziswiler@toradex.com>
References: <1452011942-11940-1-git-send-email-marcel.ziswiler@toradex.com>
 <1452011942-11940-2-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <20160108085734.GC27359@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	i2cddc: i2c at 0 {
> +		gpios = <&gpio3 16 GPIO_ACTIVE_HIGH /* sda */
> +			 &gpio2 30 GPIO_ACTIVE_HIGH /* scl */
> +			>;

According to one of the comments, it should be changed to the following:

		sda-gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
		scl-gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>;

-- ynezz
