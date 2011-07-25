From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 25 Jul 2011 23:14:00 +0200
Subject: [PATCH] ARM: mx50: Select IMX_HAVE_PLATFORM_FEC as done on other
	i.MX devices
In-Reply-To: <1311621941-4227-1-git-send-email-festevam@gmail.com>
References: <1311621941-4227-1-git-send-email-festevam@gmail.com>
Message-ID: <20110725211400.GN16561@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Mon, Jul 25, 2011 at 04:25:41PM -0300, Fabio Estevam wrote:
> -	default y if ARCH_MX25 || SOC_IMX27 || SOC_IMX35 || SOC_IMX51 || SOC_IMX53
> +	default y if ARCH_MX25 || SOC_IMX27 || SOC_IMX35 || SOC_IMX51 || SOC_IMX53 || SOC_IMX50
Maybe add i.MX50 between 35 and 51? I don't care much though.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
