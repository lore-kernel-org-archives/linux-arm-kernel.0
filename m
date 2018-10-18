From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 18 Oct 2018 20:45:32 +0200
Subject: [PATCH V2] ARM: dts: imx6qdl-icore: Add missing stdout-path
 property
In-Reply-To: <20181018150305.21408-1-shyam.saini@amarulasolutions.com>
References: <20181018150305.21408-1-shyam.saini@amarulasolutions.com>
Message-ID: <20181018184532.xe2llbhwjuffgchx@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 08:33:05PM +0530, Shyam Saini wrote:
> This would help us to get early boot logs by passing "earlycon" to
> kernel bootargs.
> 
> Further, by adding this we don't have to depend on complex earlyprintk
> configs for early boot logs.
> 
> Signed-off-by: Shyam Saini <shyam.saini@amarulasolutions.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

minor nit: your S-o-b line should be the last thing you write. So it's

	Signed-off-by: Shyam Saini <shyam.saini@amarulasolutions.com>
	Reviewed-by: Fabio Estevam <festevam@gmail.com>
	Signed-off-by: John Maintainer <john@example.org>

if John added the Reviewed-by tag and 

	Reviewed-by: Fabio Estevam <festevam@gmail.com>
	Signed-off-by: Shyam Saini <shyam.saini@amarulasolutions.com>
	Signed-off-by: John Maintainer <john@example.org>

if it was you.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
