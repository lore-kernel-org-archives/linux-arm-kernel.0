From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 4 Apr 2011 15:34:43 +0200
Subject: [PATCH] ARM: mx3/pcm043: Remove unneeded esdhc.h define
In-Reply-To: <1301923166-13220-1-git-send-email-fabio.estevam@freescale.com>
References: <1301923166-13220-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110404133443.GE30938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Mon, Apr 04, 2011 at 10:19:26AM -0300, Fabio Estevam wrote:
> "devices-imx35.h" includes <mach/devices-common.h>; and the latter
> includes <mach/esdhc.h>, so no need to include it again in mach-pcm043.c.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
good intention, but I have a more complete patch 

	ARM: imx: don't #include files that come via "devices-imxXY.h", too

(not yet posted though). I intend to send out my pending patches later
today.

Best regards and thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
