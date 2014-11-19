From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 19 Nov 2014 09:03:23 +0100
Subject: [PATCHv4 04/10] arm: mvebu: move Armada 370/XP pinctrl node
 definition armada-370-xp.dtsi
In-Reply-To: <f4b15c942f543b0c0becd7c82bce07e9e0b603cf.1416351426.git.arno@natisbad.org>
References: <cover.1416351425.git.arno@natisbad.org>
 <f4b15c942f543b0c0becd7c82bce07e9e0b603cf.1416351426.git.arno@natisbad.org>
Message-ID: <20141119080323.GS27002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnaud,

On Wed, Nov 19, 2014 at 12:02:11AM +0100, Arnaud Ebalard wrote:
> +
> +	sdio_pins: sdio-pins {
> +		marvell,pins = "mpp30", "mpp31", "mpp32",
> +			       "mpp33", "mpp34", "mpp35";
> +		marvell,function = "sd0";
> +	};
> +};
> \ No newline at end of file
IMHO you should add this \n at the end.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
