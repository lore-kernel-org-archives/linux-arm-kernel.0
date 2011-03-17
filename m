From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 17 Mar 2011 08:57:10 +0100
Subject: [PATCH 1/4] ARM: mx5/babbage: Use gpio_request_one in
	babbage_fec_reset
In-Reply-To: <1300326754-4629-1-git-send-email-festevam@gmail.com>
References: <1300326754-4629-1-git-send-email-festevam@gmail.com>
Message-ID: <20110317075710.GK13316@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2011 at 10:52:31PM -0300, Fabio Estevam wrote:
> Current code inside babbage_fec_reset uses gpio_direction_output with initial value of the GPIO and also sets 
> the GPIO value via gpio_set_value to the same level right after. This is not needed. 
> 
> By using gpio_request_one it is possible to set the direction and initial value in one shot.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> for patches
1, 3 and 4 in this series.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
