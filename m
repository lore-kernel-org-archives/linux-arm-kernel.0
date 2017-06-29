From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 29 Jun 2017 20:18:29 +0200
Subject: [PATCH RESEND] serial: imx: Enable RTSD only when needed
In-Reply-To: <20170628135936.30537-1-romain.perier@collabora.com>
References: <20170628135936.30537-1-romain.perier@collabora.com>
Message-ID: <20170629181829.7ig6ze3virfbp67e@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jun 28, 2017 at 03:59:36PM +0200, Romain Perier wrote:
> +	temp |= UCR1_RRDYEN | UCR1_UARTEN;
> +	if (sport->have_rtscts)
> +			temp |= UCR1_RTSDEN;

There is a tab too much.
 
>  	writel(temp, sport->port.membase + UCR1);

Other than that:
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
