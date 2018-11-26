From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 26 Nov 2018 21:49:24 +0100
Subject: [PATCH v3 5/6] DEV: CLK: sunxi ccu: export clk_apb1 for
 sun8i-r40 soc pwm.
In-Reply-To: <20181125162203.GA5392@arx-s1>
References: <20181125162203.GA5392@arx-s1>
Message-ID: <20181126204924.z2b7pwzeu6sqorxw@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 12:22:03AM +0800, Hao Zhang wrote:
> +#define CLK_APB1                27

This is already used in patch 2, so the patches must be reordered.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
