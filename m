From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 4 Jun 2014 15:00:42 +0200
Subject: [PATCH] irqchip: nvic: Use the generic noop function
In-Reply-To: <1401885425-12378-1-git-send-email-daniel.thompson@linaro.org>
References: <1401885425-12378-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140604130042.GJ16741@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 01:37:05PM +0100, Daniel Thompson wrote:
> Using the generic function saves looking up this custom one in a source
> navigator.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
